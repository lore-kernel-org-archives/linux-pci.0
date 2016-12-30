Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
To: Lukas Wunner <lukas@wunner.de>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <20161228161816.GA19653@bhelgaas-glaptop.roam.corp.google.com>
 <2046793688.407.1483005524737.JavaMail.zimbra@quantumtechnology.info>
 <521048803.418.1483027350066.JavaMail.zimbra@quantumtechnology.info>
 <472708904.419.1483028422817.JavaMail.zimbra@quantumtechnology.info>
 <20161229175028.GA18510@wunner.de>
 <52715138.511.1483053634089.JavaMail.zimbra@quantumtechnology.info>
 <20161230000731.GB18700@wunner.de>
 <1180505121.522.1483056977880.JavaMail.zimbra@quantumtechnology.info>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci
 <linux-pci@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Kilian Singer <kilian.singer@quantumtechnology.info>
Message-ID: <3ae00c72-a4e1-dd97-e9d4-2450ee274b72@quantumtechnology.info>
Date: Fri, 30 Dec 2016 01:24:19 +0100
MIME-Version: 1.0
In-Reply-To: <1180505121.522.1483056977880.JavaMail.zimbra@quantumtechnology.info>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

The

echo on > /sys/bus/pci/devices/0000:00:1c.0/power/control

did not help neither.
