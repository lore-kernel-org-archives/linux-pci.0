Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E9C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 21:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD0920823
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 21:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfCZVTG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 17:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfCZVTF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 Mar 2019 17:19:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 67F66E6A6F;
        Tue, 26 Mar 2019 21:19:05 +0000 (UTC)
Received: from x1.home (ovpn-116-99.phx2.redhat.com [10.3.116.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D9DC1001E84;
        Tue, 26 Mar 2019 21:19:03 +0000 (UTC)
Date:   Tue, 26 Mar 2019 15:19:03 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Matthew Garrett <mjg59@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH V31 10/25] PCI: Lock down BAR access when the kernel is
 locked down
Message-ID: <20190326151903.257724d5@x1.home>
In-Reply-To: <CALCETrW43Syz-deM-fGUCbWfA8tcsoCJJ5XqjFhpg+d0sNYDRA@mail.gmail.com>
References: <20190326182742.16950-1-matthewgarrett@google.com>
        <20190326182742.16950-11-matthewgarrett@google.com>
        <CALCETrW43Syz-deM-fGUCbWfA8tcsoCJJ5XqjFhpg+d0sNYDRA@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 26 Mar 2019 21:19:05 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 26 Mar 2019 13:55:39 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
> <matthewgarrett@google.com> wrote:
> >
> > From: Matthew Garrett <mjg59@srcf.ucam.org>
> >
> > Any hardware that can potentially generate DMA has to be locked down in
> > order to avoid it being possible for an attacker to modify kernel code,
> > allowing them to circumvent disabled module loading or module signing.
> > Default to paranoid - in future we can potentially relax this for
> > sufficiently IOMMU-isolated devices.  
> 
> Does this break vfio?

No, vfio provides its own interface to pci config space.  Thanks,

Alex
