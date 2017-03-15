Return-Path: <SRS0=2gdu=2Y=free.fr=slash.tmp@kernel.org>
Return-Path: <SRS0=2gdu=2Y=free.fr=slash.tmp@kernel.org>
Subject: Re: Enumerating an empty bus hangs the entire system
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci <linux-pci@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 David Laight <david.laight@aculab.com>, Robin Murphy <robin.murphy@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Thibaud Cornic <thibaud_cornic@sigmadesigns.com>,
 Phuong Nguyen <phuong_nguyen@sigmadesigns.com>
References: <1eeea8ff-0840-a005-38b4-61f3c253cee1@free.fr>
 <20170315160238.GB5073@bhelgaas-glaptop.roam.corp.google.com>
From: Mason <slash.tmp@free.fr>
Message-ID: <135a0b18-caa3-d3c2-8ea5-6959e70e75ac@free.fr>
Date: Wed, 15 Mar 2017 17:13:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170315160238.GB5073@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-pci.vger.kernel.org>

On 15/03/2017 17:02, Bjorn Helgaas wrote:

> If checking for link in your accessor is the best you can do, maybe
> that's all you can do.  I thought there was another driver that did
> that, but I can't find it now.  It doesn't seem perfectly safe to me,
> since the link could go down after you check for "link up" and before
> you actually issue the read.

Are you thinking of some hotplug scenario?

My system doesn't support hotplug, and I naively thought that the
link would be down if there is no card, and up shortly after reset
if there is a card.

Regards.
