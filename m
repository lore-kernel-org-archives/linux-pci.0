Return-Path: <SRS0=EwoT=32=sigmadesigns.com=Marc_Gonzalez@kernel.org>
Return-Path: <SRS0=EwoT=32=sigmadesigns.com=Marc_Gonzalez@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci <linux-pci@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Outstanding PCI patches for v4.12
Message-ID: <22298ba2-2c3b-2d1b-a419-0be0aa4b2746@sigmadesigns.com>
Date: Tue, 18 Apr 2017 11:52:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

I have two outstanding patches that are good candidates for v4.12
(short and simple).

#1
[PATCH] PCI: Change pci_host_common_probe visibility
Message-ID: <11bd9bd5-5d96-bd7c-24c7-5f262a46085c@sigmadesigns.com>

NB: Arnd submitted an alternative patch a week before I did:

https://patchwork.kernel.org/patch/9637045/
https://patchwork.kernel.org/patch/9649993/


#2
[PATCH] PCI: Improve __pci_read_base robustness
Message-ID: <1c0ad12a-9bfc-2a76-ee76-6ab403f912d3@sigmadesigns.com>


If there's anything wrong with either patch, I can quickly fix it,
hopefully in time for v4.12

(It looks like Tango PCIe controller support will have to wait until
v4.13 though.)

Regards.
