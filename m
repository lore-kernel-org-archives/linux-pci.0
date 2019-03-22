Return-Path: <SRS0=nTPQ=RZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66074C43381
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 313B021929
	for <linux-pci@archiver.kernel.org>; Fri, 22 Mar 2019 16:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553273475;
	bh=6Innu0l4fJVjRs+PzWv0iPhNGdT4HcVKkNrHsJUnb3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o4UEcNXBr2mDBfbUIrwvAFSUxnWyrfLC85W6JchymBHcvqzHcu4FHQZ7tTLmTujV2
	 9Gck+sK1vNQ7cLeJINf87IFwrxZF4rYTUSSei3TUrlvXJH/x/uWGcDnPUT0zErZwqS
	 Jhv/vnE4bIunj8snDS/0yZD0w8O2sLGHCl/aDMj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfCVQvO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:51:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbfCVQvO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Mar 2019 12:51:14 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 113A320850;
        Fri, 22 Mar 2019 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553273473;
        bh=6Innu0l4fJVjRs+PzWv0iPhNGdT4HcVKkNrHsJUnb3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EP4tEBpLsgH+yMxNfDIctcUOf1/ZUK9wqGKQUbCF1+cmAB49yl+mjZp2dWNFogzQI
         /966I53iko4Y8Rj5JLHT7VV4BB4cjdklovoBnGrrBCzgCJeFTbXIPegW4jP+fCEWRP
         k3mQ4B2vh8kLSaF18ahpDf3AuZpI16BlDqV6ggT4=
Date:   Fri, 22 Mar 2019 11:51:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Joerg Roedel <joro@8bytes.org>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>
Subject: Re: [PATCH v3 03/10] NTB: Introduce helper functions to calculate
 logical port number
Message-ID: <20190322165111.GO251185@google.com>
References: <20190322000645.15580-1-logang@deltatee.com>
 <20190322000645.15580-4-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322000645.15580-4-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 21, 2019 at 06:06:38PM -0600, Logan Gunthorpe wrote:
> This patch introduces the "Logical Port Number" which is similar to the
> "Port Number" in that it enumerates the ports in the system.
> 
> The original (or Physical) "Port Number" can be any number used by the
> hardware to uniquley identify a port in the system. The "Logical Port

s/uniquley/uniquely/

> Number" enumerates all ports in the system from 0 to the number of
> ports minus one.
> 
> For example a system with 5 ports might have the following port numbers
> which would be enumareted thusly:

s/enumareted/enumerated/

> + * ntb_logical_port_number() - get the logical port number of the local port
> + * @ntb:	NTB device context.
> + *
> + * The Logical Port Number is defined to be a unique number for each
> + * port starting from zero through to the number of ports minus one.
> + * This is in contrast to the Port Number where each port can be assigned
> + * any unqique physical number by the hardware.

s/unqique/unique/

> + * ntb_peer_logical_port_number() - get the logical peer port by given index
> + * @ntb:	NTB device context.
> + * @pidx:	Peer port index.
> + *
> + * The Logical Port Number is defined to be a unique number for each
> + * port starting from zero through to the number of ports minus one.
> + * This is in contrast to the Port Number where each port can be assigned
> + * any unqique physical number by the hardware.

s/unqique/unique/

Bjorn
