Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A476E35A3AD
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217115; cv=none; b=VqZ9FXu0mJAGfmTQE3+r6t/K7lCz/ZmSlWcmL4RdALOgbnehgRoMY0s7wt6Vow+eQg4pBPWhh5H5RjNT493sccngVhtj5Ng+/HX9xinjq2cO/9JxfAGll6AfKEpyiqCNGa/DYmwsu45ZiQ6ul3wOfBpyKbWxnIjbti+s3hqJgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217115; c=relaxed/simple;
	bh=VMyK3IS5T6zxlAyxIjDbuz0vXCcz+wF1tKyL7SCLe18=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcUufIzKFAbkZESdF+1sQsrEtGeniMwgHEXkvoOhuwG5iasPZTj+sJwceGxxguRn+RJnLDnOU//n64W5GA/TD1v23fn6w7bAFPH43b3NHm2Jb50+UajtuBkMoCRYyDUnM38HR05eStgD0gm1u/+9Pp1fFsIQ1gSi/FyGyBbI5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY8w696y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY8w696y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0BBC4CEF7
	for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 08:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773217115;
	bh=VMyK3IS5T6zxlAyxIjDbuz0vXCcz+wF1tKyL7SCLe18=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=AY8w696yEP+6mEwc6/HColfyucfQEbXQAt7Np1VSggSOqvS7PO9OEbe0hYQUrCyKX
	 eZPX2MJ+bzsBEKL3KS3f6UMpox6OvRKewny/xkj/taxq/flfKWMiccMfmah+AfEzfk
	 ENx11MhDdjzWJZUia0PppoSj5BAklN3TxnV422JQUD/+Wb6RJ+Ykw8RiKrFi5bBJzI
	 mFA6OEQ/a6Os1Ja9Qf+2mij6u08AmNgL8q0B8rY79na4d9PCPV7R7iB5SiGKgXKfG8
	 xxILeDiE/d9fVqPS1U6+IBpEipNnzeskZtKmItwqYb10QtUAfAD2spUq4+UW9IJful
	 yiwLa7GbYK6BQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38a4118c4f7so57641851fa.2
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2026 01:18:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5eFCu2DJvxXAQvoAYI9UnAb9mwddWVL6/zgYe9E8VRAZNhYXND+zgnP/L/ESqxfVpKHxtUjExZcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Lqb9OrFkk66bT+ZXtPbjcsz0F9/q+Qeiu+/j5jsbMJCnHy4t
	5wWWppw4EMtN7djwqOb+vAycJjkNb2PYE3go2nblQzrKFsRpKyBCPbT7g62hfE5w6kaq1m89BkY
	FAM/uTXhD8qkJEqZnMP065KXJd7RQeVsWqs2nGBgz/A==
X-Received: by 2002:a05:651c:1473:b0:389:fe21:b33f with SMTP id
 38308e7fff4ca-38a67dca8d3mr5036661fa.1.1773217114053; Wed, 11 Mar 2026
 01:18:34 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 01:18:33 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Mar 2026 01:18:32 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260311075223.3303497-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311075223.3303497-1-wenst@chromium.org> <20260311075223.3303497-3-wenst@chromium.org>
Date: Wed, 11 Mar 2026 01:18:32 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mf4eCuFGGgNnBhAWRhuQ26bu_qAFbiMKx357YURA=WBDg@mail.gmail.com>
X-Gm-Features: AaiRm52ewAr7cB4TbZMKbPsFbSjM9f61VT5h7rFCrr-CoxcEKiAxT3uydDGdJfM
Message-ID: <CAMRc=Mf4eCuFGGgNnBhAWRhuQ26bu_qAFbiMKx357YURA=WBDg@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] PCI: mediatek-gen3: Move mtk_pcie_setup_irq() out
 of mtk_pcie_setup()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <helgaas@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ryder Lee <ryder.lee@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 08:52:17 +0100, Chen-Yu Tsai <wenst@chromium.org> said:
> mtk_pcie_setup_irq() just sets up the IRQ domains for PCI INTx and MSI,
> and chains them to the controller's interrupt. It's not really related
> to the setup of the actual PCIe controller.
>
> Move the mtk_pcie_setup_irq() call out of and before mtk_pcie_setup(),
> and add a proper error message for when it fails. Reorder
> mtk_pcie_irq_teardown() in the remove callback to follow. Also create
> an error path in the probe function.
>
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Link: https://lore.kernel.org/all/20260309215056.GA603013@bhelgaas/
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
