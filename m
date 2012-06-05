Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50982 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab2FETlh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2012 15:41:37 -0400
Received: by dady13 with SMTP id y13so7726116dad.19
        for <linux-pci@vger.kernel.org>; Tue, 05 Jun 2012 12:41:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120605060202.GC24358@richard>
References: <20120605032627.GA23271@richard>
	<20120605041146.GD6637@ram-ThinkPad-T61>
	<CAErSpo5ZcPLZmT0aM7H1ynpq-ZOQeAoL2omZBvZLciYWifgWog@mail.gmail.com>
	<CAE9FiQUtSAh8XZub8ZKs_i+P8qKrG18o21RWXoTiF9sx8Z7U2A@mail.gmail.com>
	<20120605060202.GC24358@richard>
Date: Tue, 5 Jun 2012 12:41:36 -0700
Message-ID: <CAE9FiQVkdH8OxBwgR9a0QS9BWkS0jOoHaGQdAZFafQtBdULQwA@mail.gmail.com>
Subject: Re: One chart on pci bridge and its bus and their children
From: Yinghai Lu <yinghai@kernel.org>
To: Richard Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ram Pai <linuxram@us.ibm.com>,
	linux-pci@vger.kernel.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 4, 2012 at 11:02 PM, Richard Yang
<weiyang@linux.vnet.ibm.com> wrote:
> On Mon, Jun 04, 2012 at 10:18:46PM -0700, Yinghai Lu wrote:
>
> BTW, if the dev is the hostbrige->dev, why not pci_host_bridge contain a
> field "dev"?

we have that from 3.5-rc1

>
> And, why root bus differs with other bus a lot?
> Both root bus and other bus use self/bridge point to the "PCI BRIDGE"
> device.
> I think we can determine whether this is a root bus by bus->parent?

self is for real pci dev bridge.
bridge is the for pci_dev bridge generic device pointer. or host
bridge device pointer.

Yinghai
