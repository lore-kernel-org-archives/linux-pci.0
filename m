Return-Path: <SRS0=zPYp=2A=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1695C00454
	for <linux-pci@archiver.kernel.org>; Tue, 10 Dec 2019 21:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB1324688
	for <linux-pci@archiver.kernel.org>; Tue, 10 Dec 2019 21:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012066;
	bh=2ykNyvGZMJo7g3XX2Ffo2Sm4t/OZWneo6t2EKj0O0vs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=kxRmeGjcsR3sKfXqW7nLAZo6qnMiuuOkNTvhzy+JW4vKqTBJlrW6+mII3nPGcLgst
	 rK5LmmTMaNGD/dtLpFSuFAxV/gu6Zz96ENGUlDFhoHxmk6+qWTop9tzijP0Mwdyo7M
	 bUqja/bMMinsdqKItKJtZaEoVIG3bru3CFd2q2A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfLJVHp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:07:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbfLJVHo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 16:07:44 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86E82467E;
        Tue, 10 Dec 2019 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012064;
        bh=2ykNyvGZMJo7g3XX2Ffo2Sm4t/OZWneo6t2EKj0O0vs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tiZ5TXWGgfMMcgH1qAGW16vBSyFbf8QVFgba/3MyF+aPuDTbo4hJyiKvDLa/T3dHf
         QC17RvTnsNWgjsiKExbDTckPZJk/RCI/j1M9mCOmDjgARxC0K8V6pKEybDPhvvojm+
         0dNknNsvmHuDSPRrzN1/QfLHPNP0Fm1IwVXvM5HU=
Date:   Tue, 10 Dec 2019 15:07:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux-foundation.org, joro@8bytes.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, eric.auger@redhat.com,
        jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v3 12/13] PCI/ATS: Add PASID stubs
Message-ID: <20191210210741.GA143420@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209180514.272727-13-jean-philippe@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 07:05:13PM +0100, Jean-Philippe Brucker wrote:
> The SMMUv3 driver, which may be built without CONFIG_PCI, will soon gain
> PASID support.  Partially revert commit c6e9aefbf9db ("PCI/ATS: Remove
> unused PRI and PASID stubs") to re-introduce the PASID stubs, and avoid
> adding more #ifdefs to the SMMU driver.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci-ats.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
> index 5d62e78946a3..d08f0869f121 100644
> --- a/include/linux/pci-ats.h
> +++ b/include/linux/pci-ats.h
> @@ -33,6 +33,9 @@ void pci_disable_pasid(struct pci_dev *pdev);
>  int pci_pasid_features(struct pci_dev *pdev);
>  int pci_max_pasids(struct pci_dev *pdev);
>  #else /* CONFIG_PCI_PASID */
> +static inline int pci_enable_pasid(struct pci_dev *pdev, int features)
> +{ return -EINVAL; }
> +static inline void pci_disable_pasid(struct pci_dev *pdev) { }
>  static inline int pci_pasid_features(struct pci_dev *pdev)
>  { return -EINVAL; }
>  static inline int pci_max_pasids(struct pci_dev *pdev)
> -- 
> 2.24.0
> 
