Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34420 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545AbcG2VDO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2016 17:03:14 -0400
Received: by mail-pf0-f182.google.com with SMTP id p64so35958569pfb.1
        for <linux-pci@vger.kernel.org>; Fri, 29 Jul 2016 14:03:14 -0700 (PDT)
Date: Fri, 29 Jul 2016 14:03:26 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Amir Levy <amir.jer.levy@intel.com>
Cc: andreas.noever@gmail.com, gregkh@linuxfoundation.org,
	bhelgaas@google.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, thunderbolt-linux@intel.com,
	mika.westerberg@intel.com, tomas.winkler@intel.com
Subject: Re: [PATCH v5 4/8] thunderbolt: Communication with the ICM
 (firmware)
Message-ID: <20160729140326.1fae0ced@xeon-e3>
In-Reply-To: <1469693721-5641-5-git-send-email-amir.jer.levy@intel.com>
References: <1469693721-5641-1-git-send-email-amir.jer.levy@intel.com>
	<1469693721-5641-5-git-send-email-amir.jer.levy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 28 Jul 2016 11:15:17 +0300
Amir Levy <amir.jer.levy@intel.com> wrote:

> +int nhi_send_message(struct tbt_nhi_ctxt *nhi_ctxt, enum pdf_value pdf,
> +		     u32 msg_len, const u8 *msg, bool ignore_icm_resp)
> +{

Why not make msg a void * and not have to do so many casts?
