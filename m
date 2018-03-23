Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zimbra1.kalray.eu ([92.103.151.219]:59604 "EHLO
        zimbra1.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWH2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Mar 2018 03:28:09 -0400
Date: Fri, 23 Mar 2018 08:28:07 +0100 (CET)
From: Marta Rybczynska <mrybczyn@kalray.eu>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>, axboe@fb.com, hch@lst.de,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Message-ID: <2116255963.5924726.1521790087788.JavaMail.zimbra@kalray.eu>
In-Reply-To: <20180321215308.GH38649@bhelgaas-glaptop.roam.corp.google.com>
References: <744877924.5841545.1521630049567.JavaMail.zimbra@kalray.eu> <20180321115037.GA26083@ming.t460p> <464125757.5843583.1521634231341.JavaMail.zimbra@kalray.eu> <20180321154807.GD22254@ming.t460p> <20180321160238.GF12909@localhost.localdomain> <1220434088.5871933.1521648656789.JavaMail.zimbra@kalray.eu> <20180321215308.GH38649@bhelgaas-glaptop.roam.corp.google.com>
Subject: Re: [RFC PATCH] nvme: avoid race-conditions when enabling devices
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> On Wed, Mar 21, 2018 at 05:10:56PM +0100, Marta Rybczynska wrote:
>> 
>> The problem may happen also with other device doing its probe and
>> nvme running its workqueue (and we probably have seen it in practice
>> too). We were thinking about a lock in the pci generic code too,
>> that's why I've put the linux-pci@ list in copy.
> 
> Yes, this is a generic problem in the PCI core.  We've tried to fix it
> in the past but haven't figured it out yet.
> 
> See 40f11adc7cd9 ("PCI: Avoid race while enabling upstream bridges")
> and 0f50a49e3008 ("Revert "PCI: Avoid race while enabling upstream
> bridges"").
> 
> It's not trivial, but if you figure out a good way to fix this, I'd be
> thrilled.
> 

Bjorn, Srinath, are you aware of anyone working on an updated fix
for this one?

Marta
