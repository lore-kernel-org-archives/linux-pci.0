Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <1180505121.522.1483056977880.JavaMail.zimbra@quantumtechnology.info>
 <3ae00c72-a4e1-dd97-e9d4-2450ee274b72@quantumtechnology.info>
 <2589829.sCArIQeDWm@aspire.rjw.lan>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Kilian Singer <kilian.singer@quantumtechnology.info>
Message-ID: <ee766ef2-04a0-9014-9b82-5c507665ba5a@quantumtechnology.info>
Date: Fri, 30 Dec 2016 01:45:53 +0100
MIME-Version: 1.0
In-Reply-To: <2589829.sCArIQeDWm@aspire.rjw.lan>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

The touchpad and builtin keyboard of laptop fail.
But also connected usb keyboard and usb mouse fail.

In both cases mouse pointer is still moveable.
