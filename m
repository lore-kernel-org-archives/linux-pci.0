Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9F8C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 10:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B81920820
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 10:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JrwU76sa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B81920820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405465AbeKVVio (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:38:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405240AbeKVVin (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Nov 2018 16:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZVnWTO+qw6F2MgkYBdFjeCSWw89UYShXKa+UuGP9SlE=; b=JrwU76sa/wAvADJAG4y4+xH5Q
        bYpzcAEExfMlUPocQyzr+6nnRIPrH2INFIxtqywV/J8XXTTfDBUcMNqlL7EB+pDrxyhfh9LWhNUkA
        F8gW9olDZee2Wx6kQrINbNJVlGwd/VlUZdGG06rIgwfoOt52QsSE34KqFg+hRfbV0dk/jRZU7aH14
        DlZUpkxUQoAGdTgcLqQ4ioNCwgdftLIPblULYm+CFHUX5N3LNdfiqmdJCJ9INsJKYad+qQPQAtaSL
        dZqA8O1UIdShi8LMGa3uumP3wLe0+yIKDt131sl0zUySgTtEvFwKVOXbjPscUczqt62IjiMyRDprd
        vFfh1if7Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPmhq-0003V5-BO; Thu, 22 Nov 2018 10:59:34 +0000
Date:   Thu, 22 Nov 2018 02:59:34 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Yehezkel Bernat <yehezkelshb@gmail.com>, ashok.raj@intel.com,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        michael.jamet@intel.com, Christian Kellner <ckellner@redhat.com>,
        rjw@rjwysocki.net, Anthony Wong <anthony.wong@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        iommu@lists.linux-foundation.org, lukas@wunner.de,
        jacob.jun.pan@intel.com, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 1/4] PCI / ACPI: Identify external PCI devices
Message-ID: <20181122105934.GA13325@infradead.org>
References: <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
 <20181115191026.GE4179@lahna.fi.intel.com>
 <20181116091804.GA4548@infradead.org>
 <20181116093210.GK4179@lahna.fi.intel.com>
 <20181122104840.GO4179@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181122104840.GO4179@lahna.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 22, 2018 at 12:48:40PM +0200, Mika Westerberg wrote:
> We had an internal discussion regarding this and it was suggested that
> the new flag is called "is_untrusted" instead of "is_external". This
> covers Thunderbolt devices currently but can be extend to any other PCIe
> device such as "SD express" ones. When IOMMU is turned on it will then
> make sure devices with "is_untrusted" set are always using full IOMMU
> protection.
> 
> Any comments, objections? I was going to send v2 with this change
> included.

Sounds good to me as long as it goes along with a nice fat comment
explaining it.
