Return-Path: <SRS0=TBtX=UL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481BEC31E46
	for <linux-pci@archiver.kernel.org>; Wed, 12 Jun 2019 18:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186EC208CA
	for <linux-pci@archiver.kernel.org>; Wed, 12 Jun 2019 18:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+yPOCD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfFLSQD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 12 Jun 2019 14:16:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40291 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFLSQD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 14:16:03 -0400
Received: by mail-lf1-f66.google.com with SMTP id a9so12924718lff.7;
        Wed, 12 Jun 2019 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6scVyi5/6EmIRcgto0Na/VJ5N5CVM846bcUE48dWg2I=;
        b=X+yPOCD/NxBOb31MI5Q3P4/b32BW9lIusVp4m0mIi4jhsSXQkHopcDMp5tW3PY/NfJ
         27SsUjR+8B+aqQ2DA6ibqwfNLv7KRDaJFzOGPD+99aHZJ8PHwHXGoE0yNdFVb1IWMGSa
         zTNi5BnUIIu8tH5uMGn7Vd5Z1S9tng53JHb4mRH0O0J7FHW4qu8s+VDiEOIh1CiEN0X0
         cSLevUxO3T0L41ZQJa5DmfL10XPWMldOpmGCpB2QoqPE0r2Vn4/DiTXTpz21iE7e/yKc
         +pmH9a3i2uOmegoW/eNaQRaGEAeRctMccTz9s8HAtmNLGzVXZd0a4irYr/2L0uYD/0kE
         2UAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6scVyi5/6EmIRcgto0Na/VJ5N5CVM846bcUE48dWg2I=;
        b=GoIhUrPA4Q5YbdUqopYFroEQRyT5fJJnuf8cuvBKRL/e9rjcpiriH8HcNEQRRONfM8
         lnORPpj+zCZqcZDeofSFk0ZB/2osFubj0iJejjPo1/KMlworxd5v2tJM/mE2lk/aOseG
         9AQStVBd6EUP04TAmOnEC0i9Zs52PW4W7FoFfnWjNv7AgX3kIDktnBR4VvaTlSfZT0uV
         7JS1ffXBhz02QeJqdImdTK0SpiY34ogfUED6z2R92GPJzI67NNK2nAOQYWFUBo+pNfLb
         rAuW1NVxN9OmUQ53/NoFbla31zKbclbuB0AFOuQJnNye797clH0oF7Be9cFnI0o003zy
         BgFw==
X-Gm-Message-State: APjAAAUX3f97WeayZjSs6FU4jseLappGCZgRm82zFw9MNJdeD2u3hsvZ
        PhKgIrNp8IH1PG327FybXvSCAd+TunU8/I0ALV4=
X-Google-Smtp-Source: APXvYqwNNZksNnY0e+bu14MoUVitGVtdwAL3BPwJ1LbrrpqDe6JcUdoWmWUu7lM8N6et2a9G8/JnHXZn6XUHLqaQovI=
X-Received: by 2002:a19:6703:: with SMTP id b3mr42781218lfc.153.1560363361070;
 Wed, 12 Jun 2019 11:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190612170647.43220-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20190612170647.43220-1-sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Myron Stowe <myron.stowe@gmail.com>
Date:   Wed, 12 Jun 2019 12:15:49 -0600
Message-ID: <CAL-B5D0BF4z-H5Knj-88BBMh5Oh_cW+mT5_AE8ySrtpsZnTtBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] PCI/IOV: Fix incorrect cfg_size for VF > 0
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, ashok.raj@intel.com,
        Keith Busch <keith.busch@intel.com>, mike.campin@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This looks to basically be a duplicate of what Alex Williamson posted
8 days ago: https://lore.kernel.org/linux-pci/20190604143617.0a226555@x1.home/
Alex says Hao Zheng had a similar patch as well.

On Wed, Jun 12, 2019 at 12:08 PM
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> Commit 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> other VFs") calculates and caches the cfg_size for VF0 device before
> initializing the pcie_cap of the device which results in using incorrect
> cfg_size for all VF devices > 0. So set pcie_cap of the device before
> calculating the cfg_size of VF0 device.
>
> Fixes: 975bb8b4dc93 ("PCI/IOV: Use VF0 cached config space size for
> other VFs")
> Cc: Ashok Raj <ashok.raj@intel.com>
> Suggested-by: Mike Campin <mike.campin@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>
> Changes since v1:
>  * Fixed a typo in commit message.
>
>  drivers/pci/iov.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 3aa115ed3a65..2869011c0e35 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -160,6 +160,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
>         virtfn->device = iov->vf_device;
>         virtfn->is_virtfn = 1;
>         virtfn->physfn = pci_dev_get(dev);
> +       virtfn->pcie_cap = pci_find_capability(virtfn, PCI_CAP_ID_EXP);
>
>         if (id == 0)
>                 pci_read_vf_config_common(virtfn);
> --
> 2.21.0
>
