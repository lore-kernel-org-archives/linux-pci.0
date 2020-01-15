Return-Path: <SRS0=Q3uD=3E=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5B4C3F68F
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 16:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A7F524679
	for <linux-pci@archiver.kernel.org>; Wed, 15 Jan 2020 16:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579106583;
	bh=fJApyuntPyejoeMn12vz+APsEX7vQKt1nCchJ8JsFZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sfI9bsscZLfHzRTcx1aCq6E4Ptj/dZJSO0rRn3NIQ4Tctj484cXPBOCHwsMRuocZT
	 7q0sHRAnpHum+vHdZvkhewdVv3pQ6WRmXNOBVF+E4stQ12AJ24EgfAZDSpATmwT10b
	 EI+8+bkbzXNth+jSlmkBtGlraPfo3flOLeU6YFCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAOQnC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 15 Jan 2020 11:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgAOQnC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jan 2020 11:43:02 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A152081E;
        Wed, 15 Jan 2020 16:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579106582;
        bh=fJApyuntPyejoeMn12vz+APsEX7vQKt1nCchJ8JsFZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fYFmh46g2DI//JufPVgq0BeHAGjhlNgl4fsN9XiOgjIAh5C+ueN3A2T8ZbKmWXxb6
         l2TMNhiqS5KrRTt2RqVVniFLr8drjLE29SSrEBJiR0g/pcNzx3Efig1LeBT5aaumqT
         4V+EC1XPv3qVsagsI/6A7sLA+1pd/hMbsNrLUlY8=
Date:   Wed, 15 Jan 2020 16:42:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        robin.murphy@arm.com, bhelgaas@google.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v5 00/13] iommu: Add PASID support to Arm SMMUv3
Message-ID: <20200115164255.GB30746@willie-the-truck>
References: <20200115125239.136759-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115125239.136759-1-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 15, 2020 at 01:52:26PM +0100, Jean-Philippe Brucker wrote:
> Since v4 [1] I addressed some of Will's comment.

Thanks! I've tentatively managed to queue all of this apart from the last
patch, since that relies on some pasid symbols being exported from the PCI
core when building the driver as a module with PCI_PASID=y.

Please can you look at the rest of things here?:

https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates

> Still missing and will be submitted as follow-up patches:
> * write STE.V with WRITE_ONCE() (patch 7)

I've hacked that one up myself.

> * batch submission of CD invalidation (patch 7)

That can be 5.7 material.

> * Remove WARN_ON_ONCE() in add_device() (patch 13)
>   Pending Robin's input.

I've written that one too, but we'll see what Robin says. The question now
is which commit do I tag in the branch above :)

Will
