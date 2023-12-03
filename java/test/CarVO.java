package test;

public class CarVO {
    private String CAR_ID;
    private String CAR_NAME;
    private String CAR_BRAND;
    private String CAR_FUEL;
    private String engineCapacity;
    private String fuelEfficiency;
    private String CAR_PRICE;
    private String CAR_TYPE;
    private String CAR_LINK;
    private byte[] imagedata;

    // Getter 및 Setter 메서드

    public String getId() {
        return CAR_ID;
    }

    public void setId(String id) {
        this.CAR_ID = id;
    }

    public String getCarName() {
        return CAR_NAME;
    }

    public void setCarName(String carName) {
        this.CAR_NAME = carName;
    }

    public String getManufacturer() {
        return CAR_BRAND;
    }

    public void setManufacturer(String manufacturer) {
        this.CAR_BRAND = manufacturer;
    }

    public String getFuelType() {
        return CAR_FUEL;
    }

    public void setFuelType(String fuelType) {
        this.CAR_FUEL = fuelType;
    }

    public String getEngineCapacity() {
        return engineCapacity;
    }

    public void setEngineCapacity(String engineCapacity) {
        this.engineCapacity = engineCapacity;
    }

    public String getFuelEfficiency() {
        return fuelEfficiency;
    }

    public void setFuelEfficiency(String fuelEfficiency) {
        this.fuelEfficiency = fuelEfficiency;
    }

    public String getPrice() {
        return CAR_PRICE;
    }

    public void setPrice(String price) {
        this.CAR_PRICE = price;
    }

    public String getCarType() {
        return CAR_TYPE;
    }

    public void setCarType(String carType) {
        this.CAR_TYPE = carType;
    }
    public String getCarlink() {
        return CAR_LINK;
    }

    public void setgetCarlink(String getCarlink) {
        this.CAR_LINK = getCarlink;
    }
    public byte[] getImagedata() {
		return imagedata;
	}
	public void setImagedata(byte[] imagedata) {
		this.imagedata = imagedata;
	}
}