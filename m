Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAErSpo7xuhxv5Fev1JCKdK72fKFN8TGdAL3g8JcE8SLUzfXKSw@mail.gmail.com>
References: <20120903165831.29aed72c.izumi.taku@jp.fujitsu.com>
	<20120903170602.375b00cc.izumi.taku@jp.fujitsu.com>
	<CAErSpo54LO_mow3dNSJ2-Aj4xBs=Zrk9fiAuFzZKdh9=YKyWuA@mail.gmail.com>
	<CAE9FiQVHgLGCmU2GTPkRKO8qRrWDwXOXNXoOf0OxvjWJBPLWMA@mail.gmail.com>
	<CAErSpo7xuhxv5Fev1JCKdK72fKFN8TGdAL3g8JcE8SLUzfXKSw@mail.gmail.com>
Date: Thu, 13 Sep 2012 14:17:04 -0700
Message-ID: <CAE9FiQXWU-PPJceZAafBxypMf6ieZFdLzyR9NmStbkNmmg_P5g@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] ACPI, PCI: add acpi_pci_roots protection
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, kaneshige.kenji@jp.fujitsu.com,
	jiang.liu@huawei.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 13, 2012 at 12:39 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> If I understand you correctly, you're agreeing that if we change the
> .add()/.remove() interfaces, there is no need for RCU here.  Correct
> me if I'm wrong.

yes.

just passing acpi_pci_root point or acpi_device pointer.

Yinghai
