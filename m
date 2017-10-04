Return-Path: <SRS0=Pr/s=BD=gmail.com=stuart.w.hayes@kernel.org>
Return-Path: <SRS0=Pr/s=BD=gmail.com=stuart.w.hayes@kernel.org>
Subject: [PATCH] PCI: Create iov virtfn/physfn links before attaching driver
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
References: <d3328861-2da2-918d-c3db-cc0795ab1586@gmail.com>
 <20170926205745.GR15970@bhelgaas-glaptop.roam.corp.google.com>
From: Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <45746aaf-656c-3ca7-9c11-55607a8154d2@gmail.com>
Date: Wed, 4 Oct 2017 10:57:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170926205745.GR15970@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

When creating virtual functions, create the "virtfn%u" and "physfn" links 
in sysfs before attaching the driver.  Without this, there is a race when 
the driver attaches to the new virtual network interface and sends out an 
"add" udev event, and the network interface naming software (biosdevname
or systemd, for example) tries to look at these links.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---

--- linux-4.14-rc1/drivers/pci/iov.c.orig	2017-09-18 15:00:43.168255665 -0500
+++ linux-4.14-rc1/drivers/pci/iov.c	2017-09-18 15:07:04.792280999 -0500
@@ -162,7 +162,6 @@ int pci_iov_add_virtfn(struct pci_dev *d
 
 	pci_device_add(virtfn, virtfn->bus);
 
-	pci_bus_add_device(virtfn);
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
 	if (rc)
@@ -173,6 +172,8 @@ int pci_iov_add_virtfn(struct pci_dev *d
 
 	kobject_uevent(&virtfn->dev.kobj, KOBJ_CHANGE);
 
+	pci_bus_add_device(virtfn);
+
 	return 0;
 
 failed2:

---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus
