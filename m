Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320FBC43610
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 09:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8114B2245E
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 09:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQkTxLAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8114B2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeKPT3o (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:29:44 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeKPT3o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 14:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b5OutxS0GhcercmpX11Sg1tknmPeUT3sBqckvewo8zA=; b=RQkTxLAUFOLPA0J+RppItlpIB
        9kxTGUs2y4LLsgZ8EuCtZwLQLM2MMhu1rG+qls0/zIjSoV5AvMQZPzgiAteiRkkB60IFUCQuNi2Pw
        Xlkg3+1gJh0u0eLVG1GBlvVINgJXch1SU9tm6k2gb1UU4C4VjPqJchEvC3CBW//wmHqqpNrnVCUgS
        qNM73fMXTq0i66M7gARtiW6xyn1qmMDBXKkuST/tWiT/J3p5QB4BWcOYeMJ3c0L8iMtWC6ayOEhsF
        Izub2bAiZd7A+UyM1hYDB1G9pfULIjbAUY5e1DPsAqS6H4e4BFXhyUa+Vxwi2DLVDE75zEZ56Mee2
        I8nJ1dmew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNaGK-0002Gm-Ok; Fri, 16 Nov 2018 09:18:04 +0000
Date:   Fri, 16 Nov 2018 01:18:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Yehezkel Bernat <yehezkelshb@gmail.com>, ashok.raj@intel.com,
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
Message-ID: <20181116091804.GA4548@infradead.org>
References: <20181113112700.GT2500@lahna.fi.intel.com>
 <20181113114527.GA12821@e107981-ln.cambridge.arm.com>
 <20181115102239.GU2500@lahna.fi.intel.com>
 <20181115111356.GA599@e107981-ln.cambridge.arm.com>
 <20181115113737.GW2500@lahna.fi.intel.com>
 <20181115120736.pscly6zwd3k2tvd2@wunner.de>
 <20181115121627.GA2500@lahna.fi.intel.com>
 <20181115174608.GA17691@e107981-ln.cambridge.arm.com>
 <CA+CmpXv9yM6nFdb0mcMPGHS-B_uGbQHYoO6iuefZC8gWoZYD3Q@mail.gmail.com>
 <20181115191026.GE4179@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115191026.GE4179@lahna.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 15, 2018 at 09:10:26PM +0200, Mika Westerberg wrote:
> FireWire is kind of different but there are connectors such as
> ExpressCard and NVMe (over U.2 connector) which carry PCIe and are
> relatively easy to access without need for a screwdriver. AFAIK some
> eGPUs are also using some other proprietary (non-TBT) connector that
> carries PCIe.

U.2 is a data center internal form factor with hot plug capability. If
you enable an iommu for that by default you will make a lot of people
very unhappy.

More importantly NVMe is now used for the current/next generation
Compact Flash and SD cards, which contain full PCIe gen 3 links.
