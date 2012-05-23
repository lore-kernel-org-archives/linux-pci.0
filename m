Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62463 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958Ab2EWF3E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 May 2012 01:29:04 -0400
Received: by pbbrp8 with SMTP id rp8so9371227pbb.19
        for <linux-pci@vger.kernel.org>; Tue, 22 May 2012 22:29:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFeW=pZiEODGx09=HaJDWujmCc92wCKt2fhZM03yNDb9CSs3gA@mail.gmail.com>
References: <20120523043347.13449.1063.stgit@bhelgaas.mtv.corp.google.com>
	<20120523043511.13449.22006.stgit@bhelgaas.mtv.corp.google.com>
	<CAE9FiQVs0U62NRxkDYdOC67EUiEBu1f5ojGxGXkdbt0O6XO4uQ@mail.gmail.com>
	<CAFeW=pZiEODGx09=HaJDWujmCc92wCKt2fhZM03yNDb9CSs3gA@mail.gmail.com>
Date: Tue, 22 May 2012 22:29:04 -0700
Message-ID: <CAE9FiQWJcxbUvOcYf-mZYThKMogYzYUwk+w-Oc43dEU9KLA3oQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] PCI: acpiphp: remove all functions in slot, even
 without ACPI _EJx
From: Yinghai Lu <yinghai@kernel.org>
To: Amos Kong <kongjianjun@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	liuj97@gmail.com, qemu-devel@nongnu.org, jbarnes@virtuousgeek.org,
	kaneshige.kenji@jp.fujitsu.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2012 at 10:15 PM, Amos Kong <kongjianjun@gmail.com> wrote:
> Attached the v7,  test passed.

would be better to have break...

+static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
+{
+	struct pci_bus *bus = slot->bridge->pci_bus;
+	struct pci_dev *dev;
+	int ret = NULL;
+
+	down_read(&pci_bus_sem);
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (PCI_SLOT(dev->devfn) == slot->device)
+			ret = pci_dev_get(dev);
+	up_read(&pci_bus_sem);
+
+	return ret;
+}

===>


+static struct pci_dev *dev_in_slot(struct acpiphp_slot *slot)
+{
+	struct pci_bus *bus = slot->bridge->pci_bus;
+	struct pci_dev *dev;
+	int ret = NULL;
+
+	down_read(&pci_bus_sem);
+	list_for_each_entry(dev, &bus->devices, bus_list)
+		if (PCI_SLOT(dev->devfn) == slot->device) {
+			ret = pci_dev_get(dev);
+                      break;
+              }
+	up_read(&pci_bus_sem);
+
+	return ret;
+}
