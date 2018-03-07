Return-Path: <SRS0=ZjzQ=F5=intel.com=fengguang.wu@kernel.org>
Return-Path: <SRS0=ZjzQ=F5=intel.com=fengguang.wu@kernel.org>
Date: Thu, 8 Mar 2018 00:57:16 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>
Subject: [pci:next 34/50] drivers/pci/probe.c:1465:19: error: 'struct
 pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
Message-ID: <201803080015.CzPERYDN%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
List-ID: <linux-pci.vger.kernel.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
head:   36e218fd55522ccfd4463fbf57909353e58280bd
commit: 25210702e2122f42f6b2f44e0446e819d44bf113 [34/50] PCI/IOV: Use VF0 cached config registers for other VFs
config: x86_64-randconfig-x017-201809 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 25210702e2122f42f6b2f44e0446e819d44bf113
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/pci/probe.c: In function 'pci_setup_device':
>> drivers/pci/probe.c:1465:19: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
      hdr_type = dev->physfn->sriov->hdr_type;
                      ^~~~~~
                      is_physfn
   drivers/pci/probe.c:1490:16: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
      class = dev->physfn->sriov->class;
                   ^~~~~~
                   is_physfn
   drivers/pci/probe.c:1533:33: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
       dev->subsystem_vendor = dev->physfn->sriov->subsystem_vendor;
                                    ^~~~~~
                                    is_physfn
   drivers/pci/probe.c:1534:33: error: 'struct pci_dev' has no member named 'physfn'; did you mean 'is_physfn'?
       dev->subsystem_device = dev->physfn->sriov->subsystem_device;
                                    ^~~~~~
                                    is_physfn

vim +1465 drivers/pci/probe.c

  1444	
  1445	/**
  1446	 * pci_setup_device - Fill in class and map information of a device
  1447	 * @dev: the device structure to fill
  1448	 *
  1449	 * Initialize the device structure with information about the device's
  1450	 * vendor,class,memory and IO-space addresses, IRQ lines etc.
  1451	 * Called at initialisation of the PCI subsystem and by CardBus services.
  1452	 * Returns 0 on success and negative if unknown type of device (not normal,
  1453	 * bridge or CardBus).
  1454	 */
  1455	int pci_setup_device(struct pci_dev *dev)
  1456	{
  1457		u32 class;
  1458		u16 cmd;
  1459		u8 hdr_type;
  1460		int pos = 0;
  1461		struct pci_bus_region region;
  1462		struct resource *res;
  1463	
  1464		if (dev->is_virtfn)
> 1465			hdr_type = dev->physfn->sriov->hdr_type;
  1466		else if (pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type))
  1467			return -EIO;
  1468	
  1469		dev->sysdata = dev->bus->sysdata;
  1470		dev->dev.parent = dev->bus->bridge;
  1471		dev->dev.bus = &pci_bus_type;
  1472		dev->hdr_type = hdr_type & 0x7f;
  1473		dev->multifunction = !!(hdr_type & 0x80);
  1474		dev->error_state = pci_channel_io_normal;
  1475		set_pcie_port_type(dev);
  1476	
  1477		pci_dev_assign_slot(dev);
  1478	
  1479		/*
  1480		 * Assume 32-bit PCI; let 64-bit PCI cards (which are far rarer)
  1481		 * set this higher, assuming the system even supports it.
  1482		 */
  1483		dev->dma_mask = 0xffffffff;
  1484	
  1485		dev_set_name(&dev->dev, "%04x:%02x:%02x.%d", pci_domain_nr(dev->bus),
  1486			     dev->bus->number, PCI_SLOT(dev->devfn),
  1487			     PCI_FUNC(dev->devfn));
  1488	
  1489		if (dev->is_virtfn)
  1490			class = dev->physfn->sriov->class;
  1491		else
  1492			pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
  1493		dev->revision = class & 0xff;
  1494		dev->class = class >> 8;		    /* upper 3 bytes */
  1495	
  1496		pci_printk(KERN_DEBUG, dev, "[%04x:%04x] type %02x class %#08x\n",
  1497			   dev->vendor, dev->device, dev->hdr_type, dev->class);
  1498	
  1499		/* Need to have dev->class ready */
  1500		dev->cfg_size = pci_cfg_space_size(dev);
  1501	
  1502		/* Need to have dev->cfg_size ready */
  1503		set_pcie_thunderbolt(dev);
  1504	
  1505		/* "Unknown power state" */
  1506		dev->current_state = PCI_UNKNOWN;
  1507	
  1508		/* Early fixups, before probing the BARs */
  1509		pci_fixup_device(pci_fixup_early, dev);
  1510	
  1511		/* Device class may be changed after fixup */
  1512		class = dev->class >> 8;
  1513	
  1514		if (dev->non_compliant_bars) {
  1515			pci_read_config_word(dev, PCI_COMMAND, &cmd);
  1516			if (cmd & (PCI_COMMAND_IO | PCI_COMMAND_MEMORY)) {
  1517				pci_info(dev, "device has non-compliant BARs; disabling IO/MEM decoding\n");
  1518				cmd &= ~PCI_COMMAND_IO;
  1519				cmd &= ~PCI_COMMAND_MEMORY;
  1520				pci_write_config_word(dev, PCI_COMMAND, cmd);
  1521			}
  1522		}
  1523	
  1524		dev->broken_intx_masking = pci_intx_mask_broken(dev);
  1525	
  1526		switch (dev->hdr_type) {		    /* header type */
  1527		case PCI_HEADER_TYPE_NORMAL:		    /* standard header */
  1528			if (class == PCI_CLASS_BRIDGE_PCI)
  1529				goto bad;
  1530			pci_read_irq(dev);
  1531			pci_read_bases(dev, 6, PCI_ROM_ADDRESS);
  1532			if (dev->is_virtfn) {
  1533				dev->subsystem_vendor = dev->physfn->sriov->subsystem_vendor;
  1534				dev->subsystem_device = dev->physfn->sriov->subsystem_device;
  1535			} else {
  1536				pci_read_config_word(dev, PCI_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
  1537				pci_read_config_word(dev, PCI_SUBSYSTEM_ID, &dev->subsystem_device);
  1538			}
  1539	
  1540			/*
  1541			 * Do the ugly legacy mode stuff here rather than broken chip
  1542			 * quirk code. Legacy mode ATA controllers have fixed
  1543			 * addresses. These are not always echoed in BAR0-3, and
  1544			 * BAR0-3 in a few cases contain junk!
  1545			 */
  1546			if (class == PCI_CLASS_STORAGE_IDE) {
  1547				u8 progif;
  1548				pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
  1549				if ((progif & 1) == 0) {
  1550					region.start = 0x1F0;
  1551					region.end = 0x1F7;
  1552					res = &dev->resource[0];
  1553					res->flags = LEGACY_IO_RESOURCE;
  1554					pcibios_bus_to_resource(dev->bus, res, &region);
  1555					pci_info(dev, "legacy IDE quirk: reg 0x10: %pR\n",
  1556						 res);
  1557					region.start = 0x3F6;
  1558					region.end = 0x3F6;
  1559					res = &dev->resource[1];
  1560					res->flags = LEGACY_IO_RESOURCE;
  1561					pcibios_bus_to_resource(dev->bus, res, &region);
  1562					pci_info(dev, "legacy IDE quirk: reg 0x14: %pR\n",
  1563						 res);
  1564				}
  1565				if ((progif & 4) == 0) {
  1566					region.start = 0x170;
  1567					region.end = 0x177;
  1568					res = &dev->resource[2];
  1569					res->flags = LEGACY_IO_RESOURCE;
  1570					pcibios_bus_to_resource(dev->bus, res, &region);
  1571					pci_info(dev, "legacy IDE quirk: reg 0x18: %pR\n",
  1572						 res);
  1573					region.start = 0x376;
  1574					region.end = 0x376;
  1575					res = &dev->resource[3];
  1576					res->flags = LEGACY_IO_RESOURCE;
  1577					pcibios_bus_to_resource(dev->bus, res, &region);
  1578					pci_info(dev, "legacy IDE quirk: reg 0x1c: %pR\n",
  1579						 res);
  1580				}
  1581			}
  1582			break;
  1583	
  1584		case PCI_HEADER_TYPE_BRIDGE:		    /* bridge header */
  1585			if (class != PCI_CLASS_BRIDGE_PCI)
  1586				goto bad;
  1587	
  1588			/*
  1589			 * The PCI-to-PCI bridge spec requires that subtractive
  1590			 * decoding (i.e. transparent) bridge must have programming
  1591			 * interface code of 0x01.
  1592			 */
  1593			pci_read_irq(dev);
  1594			dev->transparent = ((dev->class & 0xff) == 1);
  1595			pci_read_bases(dev, 2, PCI_ROM_ADDRESS1);
  1596			set_pcie_hotplug_bridge(dev);
  1597			pos = pci_find_capability(dev, PCI_CAP_ID_SSVID);
  1598			if (pos) {
  1599				pci_read_config_word(dev, pos + PCI_SSVID_VENDOR_ID, &dev->subsystem_vendor);
  1600				pci_read_config_word(dev, pos + PCI_SSVID_DEVICE_ID, &dev->subsystem_device);
  1601			}
  1602			break;
  1603	
  1604		case PCI_HEADER_TYPE_CARDBUS:		    /* CardBus bridge header */
  1605			if (class != PCI_CLASS_BRIDGE_CARDBUS)
  1606				goto bad;
  1607			pci_read_irq(dev);
  1608			pci_read_bases(dev, 1, 0);
  1609			pci_read_config_word(dev, PCI_CB_SUBSYSTEM_VENDOR_ID, &dev->subsystem_vendor);
  1610			pci_read_config_word(dev, PCI_CB_SUBSYSTEM_ID, &dev->subsystem_device);
  1611			break;
  1612	
  1613		default:				    /* unknown header */
  1614			pci_err(dev, "unknown header type %02x, ignoring device\n",
  1615				dev->hdr_type);
  1616			return -EIO;
  1617	
  1618		bad:
  1619			pci_err(dev, "ignoring class %#08x (doesn't match header type %02x)\n",
  1620				dev->class, dev->hdr_type);
  1621			dev->class = PCI_CLASS_NOT_DEFINED << 8;
  1622		}
  1623	
  1624		/* We found a fine healthy device, go go go... */
  1625		return 0;
  1626	}
  1627	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
KwcPHblqajHwUWd20VSNPk4TE/t/qzJqa4TQAQA=

--sm4nu43k4a2Rpi4c--
