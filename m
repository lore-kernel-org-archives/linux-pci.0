Return-Path: <SRS0=r8rO=6P=huawei.com=gabriele.paoloni@kernel.org>
Return-Path: <SRS0=r8rO=6P=huawei.com=gabriele.paoloni@kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linuxarm
	<linuxarm@huawei.com>,
        "liudongdong (C)" <liudongdong3@huawei.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        John Garry <john.garry@huawei.com>
Subject: [QUESTION] AER report_error_detected() called for all the devices
 on the same bus as the AER reporter EP
Date: Wed, 12 Jul 2017 08:36:05 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40B30831@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn and all

I was looking into the AER error handling code. We have an SoC where we
have integrated PCIe controllers on the same bus. e.g.

RC---bus0---|-SAS ctrl
            |
            |-SATA ctrl
            |
            |- ...

Now Looking into broadcast_error_message() we can see that if the AER is
reported by an EP the code walks over all the devices connected to the
bus of its upstream port calling in turn the callback function for each
device.

[...]
	} else {
		/*
		 * If the error is reported by an end point, we think this
		 * error is related to the upstream link of the end point.
		 */
		pci_walk_bus(dev->bus, cb, &result_data);
	}
[...]

With respect to the example above if SAS is the source of the AER and for
instance it reports a non FATAL error the report_error_detected() callback
will be called also for the SATA device. If the SATA driver does not
implement dev->driver->err_handler->error_detected() report_error_detected(=
)
will return PCI_ERS_RESULT_NO_AER_DRIVER and both SAS and SATA will be left
in error state unrecovered.

Now from my understanding if we have a FATAL error it is correct to walk
over the upstream bus, as we do now; in fact in this case the PCIe link
itself is compromised, however for non FATAL errors my understanding is
that we should only walk over the other functions of a multi-funciton
device (i.e. walk over the bus till dev->multifunction =3D=3D 1).

Thoughts?

Thanks
Gab
