Return-Path: <SRS0=0U9d=T6=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976E4C28CC0
	for <linux-pci@archiver.kernel.org>; Thu, 30 May 2019 13:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEDB25982
	for <linux-pci@archiver.kernel.org>; Thu, 30 May 2019 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559222425;
	bh=WWUvePG/F5W9jMrKSPbf0krNclZJzDEIlb3GAxBTdPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AtpSdhwStVlF5LZUZz/s9nUmEg+b8Fv0m7Vr1ax9s7v/mgDUzIwwLYDPkzB+XYEcz
	 XQuFryv+xyDgMTaxR8YhFi6Cj8CF7/r1wsZF5JeXA28wEoHUhPvwmq/1WvA0xKH4/v
	 TJ2Ob3eZFH8FlljMrShZaniqx8IMXaAC1gVqqrvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfE3NUU (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 30 May 2019 09:20:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfE3NUR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 May 2019 09:20:17 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295362596C;
        Thu, 30 May 2019 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559222416;
        bh=WWUvePG/F5W9jMrKSPbf0krNclZJzDEIlb3GAxBTdPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jv6lKTJpSAmsvbT9Oc+pbk9Pt+iz2dQ6CvIDOQrDijLggnudc1qnTgggJ8e2jc6Mo
         wrtl8xLxSaK9pbN0w/QXHk779vZzPu+F9/YAjdKVH5/wOZraWPKeQIFjwCBEBggF1X
         NrnY+sX+UwXZbkACNs8yTw5tRfrF2r1BC0jdczJc=
Date:   Thu, 30 May 2019 08:20:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, keith.busch@intel.com
Subject: Re: [PATCH v2 1/5] PCI/ATS: Add PRI support for PCIe VF devices
Message-ID: <20190530132015.GL28250@google.com>
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <f773440c0eee2a8d4e5d6e2856717404ac836458.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190529225714.GE28250@google.com>
 <20190529230426.GB5108@araj-mobl1.jf.intel.com>
 <e93c7b6b-c414-6e0f-7983-9a46c67acb92@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93c7b6b-c414-6e0f-7983-9a46c67acb92@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 29, 2019 at 04:24:05PM -0700, sathyanarayanan kuppuswamy wrote:
> But, regarding VF spec compliance checks, Is there any issue in having them
> in enable code ? Perhaps I can change dev_err to dev_warn and not return
> error if it found implementation errors. I found it useful to have them
> because it helped me in finding some faulty devices during my testing. Let
> me know your comments.

If you need quirks to make these non-compliant devices usable, we
should check for compliance.  If not, my personal opinion is that we
shouldn't touch things we don't need.

Bjorn
