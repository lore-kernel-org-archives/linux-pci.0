Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C0CC43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55DF20855
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547737617;
	bh=bi0jT3sSfGkmPZz1x8nu2vzvP+BhjpkQhNeb96KS24s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iytFOlyEP33DKASNzf8iVwydh339IqLhh89rc5t7hh8CzkPb7En2yQgZhP3DqdQ+C
	 kqZXcrlhjAqFbPA/ASPr8jZ/5PupcesDy4srD+KRY93H7N5V6YjbUhuD4m8WvMcDRU
	 7tb8Wzq0y0GIA3TMG2CfvDUTL+zmijIwWZg4yB1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfAQPG4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:06:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbfAQPG4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jan 2019 10:06:56 -0500
Received: from localhost (173-25-171-118.client.mchsi.com [173.25.171.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D69E20851;
        Thu, 17 Jan 2019 15:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547737615;
        bh=bi0jT3sSfGkmPZz1x8nu2vzvP+BhjpkQhNeb96KS24s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g9PAk5QAO56mYe+R94VhyMnhqQg1T8cnCYRXbWRFurD7ReHRJoNQ2tV1IrD8HUEUh
         hfx7hGFvNJ5ya4gGudRAGgZ0l5BDdBw6WRBNtlP76n9YL7IeD+R+ock5WADyjv0Cji
         g76M6oCAQQalBlE5GLBILoEsz6dw4xA0LkeQxMpA=
Date:   Thu, 17 Jan 2019 09:06:54 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ajay Kaher <akaher@vmware.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jork Loeser <jloeser@microsoft.com>
Subject: Re: [PATCH 3/3] PCI: hv: Use vPCI protocol version 1.2 for v4.9
Message-ID: <20190117150654.GF158366@google.com>
References: <1547758038-5255-1-git-send-email-akaher@vmware.com>
 <1547758038-5255-4-git-send-email-akaher@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547758038-5255-4-git-send-email-akaher@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 18, 2019 at 02:17:18AM +0530, Ajay Kaher wrote:
> Update the Hyper-V vPCI driver to use the Server-2016 version of the vPCI
> protocol, fixing MSI creation and retargeting issues.
> 
> Replaced hv_tmp_cpu_nr_to_vp_nr() with vmbus_cpu_number_to_vp_number()
> to make this patch compatibale for linux v4.9.

s/compatibale for/compatible with/

This change (to make it compatible with v4.9) sounds like it should be
in its own separate patch.  I don't see any use of
hv_tmp_cpu_nr_to_vp_nr() being removed, so the changelog doesn't quite
make sense.

> Signed-off-by: Jork Loeser <jloeser@microsoft.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I did not sign off on this; please remove.

> Reviewed-by: K. Y. Srinivasan <kys@microsoft.com>
> Acked-by: K. Y. Srinivasan <kys@microsoft.com>
> Signed-off-by: Ajay Kaher <akaher@vmware.com>

> + * struct hv_msi_desc2 - 1.2 version of hv_msi_desc
> + * @vector:		IDT entry
> + * @delivery_mode:	As defined in Intel's Programmer's
> + *			Reference Manual, Volume 3, Chapter 8.
> + * @vector_count:	Number of contiguous entries in the
> + *			Interrupt Descriptor Table that are
> + *			occupied by this Message-Signaled
> + *			Interrupt. For "MSI", as first defined
> + *			in PCI 2.2, this can be between 1 and
> + *			32. For "MSI-X," as first defined in PCI
> + *			3.0, this must be 1, as each MSI-X table
> + *			entry would have its own descriptor.

Please reflow these descriptions to take advantage of an 80 column
width.  They are currently wrapped to fit in 50 columns, which is
unnecessarily short.

> +	default:
> +		/* As we only negotiate protocol versions known to this driver,
> +		 * this path should never hit. However, this is it not a hot
> +		 * path so we print a message to aid future updates.
> +		 */
> +		dev_err(&hbus->hdev->device,
> +			"Unexpected vPCI protocol, update driver.");

Include the actual protocol version in the message?
