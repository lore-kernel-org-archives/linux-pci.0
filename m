Return-Path: <SRS0=ZQeV=OV=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53F6C65BAF
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 21:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8728A20870
	for <linux-pci@archiver.kernel.org>; Wed, 12 Dec 2018 21:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544651381;
	bh=BseJfCoSbr12NaSR0ETRp1aeIIQKQMH5pJHANw28arc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12WEeSiBWVofs0HZI2YFXo1z6fxng+Pc0HCb2ROAu021GQTnd/mf9IKhe2lu5nq9S
	 KT40bBw0yIdK6eJxPKk84reOa7LhEMPk+UPDqNvcPgELB2+O9mrp7ZtR3zZ6FnB5ir
	 3XBSc9GNM6cEUETCkak+4KTqXMBconM5kKaCo41k=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8728A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbeLLVtk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Dec 2018 16:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbeLLVtk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Dec 2018 16:49:40 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D371720672;
        Wed, 12 Dec 2018 21:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544651379;
        bh=BseJfCoSbr12NaSR0ETRp1aeIIQKQMH5pJHANw28arc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGsgc2MCowEnqs3fJ0nroPvufL+1KKcBXRU7La5e+pmkaoLyCgZ2mIzbpWyEc1EZj
         aF7XM6iVZ5PGpkJgosPPKgDBQFSzZr3cyIUFhRTUZg2bQxrOvt3lDSQ9Z8s8sGKlZD
         rTAG7doIIJKNZpiF8bmUP4e+8JkNj26m4RclCwZ0=
Date:   Wed, 12 Dec 2018 15:49:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Stable <stable@vger.kernel.org>
Subject: Re: [PATCH v2] PCI / PM: Allow runtime PM without callback functions
Message-ID: <20181212214937.GI99796@google.com>
References: <20181023114552.22958-1-jarkko.nikula@linux.intel.com>
 <CAJZ5v0gna-KvmezNGmCJZTwMrSBHyxbXqPZi12aKjEkxkr=YPQ@mail.gmail.com>
 <14190b11-f7f1-3a27-1476-8b043bd72555@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14190b11-f7f1-3a27-1476-8b043bd72555@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 12, 2018 at 01:42:29PM +0200, Jarkko Nikula wrote:
> Hi
> 
> On 10/25/18 4:57 PM, Rafael J. Wysocki wrote:
> > On Tue, Oct 23, 2018 at 1:46 PM Jarkko Nikula
> > <jarkko.nikula@linux.intel.com> wrote:
> > > 
> > > Commit a9c8088c7988 ("i2c: i801: Don't restore config registers on
> > > runtime PM") nullified the runtime PM suspend/resume callback pointers
> > > while keeping the runtime PM enabled.
> > > 
> > > This causes that SMBus PCI device stays in D0 power state and sysfs
> > > /sys/bus/pci/devices/[SMBus PCI ID]/power/runtime_status shows "error"
> > > when the runtime PM framework attempts to autosuspend the device. This
> > > is due PCI bus runtime PM which checks for driver runtime PM callbacks
> > > and returns with -ENOSYS if they are not set.
> > > 
> > > Since i2c-i801.c don't need to do anything device specific beyond PCI
> > > device power state management Jean Delvare proposed if this can be fixed
> > > in the PCI subsystem core level rather than adding dummy runtime PM
> > > callback functions in the PCI drivers.
> > > 
> > > Change the pci_pm_runtime_suspend()/pci_pm_runtime_resume() semantics so
> > > that they allow change the PCI device power state during runtime PM
> > > transitions even if no runtime PM callback functions are defined.
> > > 
> > > This change fixes the runtime PM regression on i2c-i801.c.
> > > 
> > > It is not obvious why the code had hard requirements for the runtime PM
> > > callbacks. Test has been here since the code was introduced by the
> > > commit 6cbf82148ff2 ("PCI PM: Run-time callbacks for PCI bus type").
> > > 
> > > On the other hand similar change than this was done to generic runtime
> > > PM callbacks way back in the commit 05aa55dddb9e ("PM / Runtime: Lenient
> > > generic runtime pm callbacks").
> > > 
> > > Fixes: a9c8088c7988 ("i2c: i801: Don't restore config registers on runtime PM")
> > > Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Cc: <stable@vger.kernel.org> # 4.18+
> > > Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> I guess this patch with Reviewed-by tags from Rafael and Jean got buried
> under other list traffic as I don't find this from pci.git or linux-next?

Sorry, I totally dropped the ball on this.  I normally would interpret
Rafael's reviewed-by as an indication that he intends me to pick it
up.  My only excuse is some travel and unexpected sick time that has
put me behind.

I applied this to pci/pm for v4.21, with Reviewed-by tags from Jean
and Rafael, thanks!

Bjorn
