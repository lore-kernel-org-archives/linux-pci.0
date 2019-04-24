Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56427C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D40A21906
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 16:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556124761;
	bh=sM+v7ZDY6mVJzeKMXOV8yBVhyCEOTmgUCZE+PRsJf3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zq6aF2syHblNNKyW+v7KxBBNhqgA23Uf2xEiTKQ/MGX5K2DT3E0TwOMMlkW3ma40D
	 50ZBSYYPUhkh2CYyrqr7+V+GYyQ3eXcWB21fkLNDu11/daDCIcDAGgpWG6P601isqP
	 Cy8mbK7qkcx2lYrc87r7xCWnQUL8THD8Z7/z+rqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbfDXQwk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:52:40 -0400
Received: from casper.infradead.org ([85.118.1.10]:35990 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732439AbfDXQwk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 12:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dfaDfFq2WMrVb8w8teQDqmRHXr1poGmjBR5SGUSF5kk=; b=apvxgzVONgN/v/y+5LaL4ytTTf
        Aa8u0hZek6p+EtyIurT9iVqxNcSSG7nAeEDrOgoAuw9O6V4llL44zOETEPP5d3ntzPFIKQKVcgAnP
        7ai0Fk25T610ebHpVcR4WBFxIQKoTKNbzJZEz3JG6F9+Z9ZqCPxzTbw4XLfcRJKyzrYsD3Wy5QrKu
        ruL/a/zP2acV+7fXDKqRxByfwOs/eb1KaMUw/uZ3YDdQwSkEpkjg6xdhOjnyR6ISII0T77srkfYKD
        fO9rWmUEzvYnitf9qITragI3j2bGBreIKETC2eT81k0a29iLQI6DK2/arhQqfqu2VGH4ju9B8b/AA
        6KiX3mPA==;
Received: from 177.17.136.231.dynamic.adsl.gvt.net.br ([177.17.136.231] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hJL8M-0005a2-V1; Wed, 24 Apr 2019 16:52:35 +0000
Date:   Wed, 24 Apr 2019 13:52:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 00/63] Include linux ACPI/PCI/X86 docs into Sphinx
 TOC tree
Message-ID: <20190424135228.58cdb9be@coco.lan>
In-Reply-To: <20190424101846.7cc4bad7@lwn.net>
References: <20190423162932.21428-1-changbin.du@gmail.com>
        <20190424101846.7cc4bad7@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Em Wed, 24 Apr 2019 10:18:46 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed, 24 Apr 2019 00:28:29 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > The kernel now uses Sphinx to generate intelligent and beautiful documentation
> > from reStructuredText files. I converted all of the Linux ACPI/PCI/X86 docs to
> > reST format in this serias.
> > 
> > In this version I combined ACPI and PCI docs, and added new x86 docs conversion.  
> 
> As mentioned by others, this is a lot of stuff; I would really rather see
> each of those groups as separate patch sets.

Yeah, makes sense to me, either to split into separate patchsets or to
group the changes per sub-dir (or both).

> If you can do a reasonably quick turnaround with Mauro's suggestions
> addressed and tags applied, we should be able to get at least some of this
> into 5.2.  Thanks, Mauro, for looking at all of this stuff!

Anytime! Just to make clear, I'm still reviewing it... I'm at patch 35/63
now. So, expect more comments from my side.


Thanks,
Mauro
