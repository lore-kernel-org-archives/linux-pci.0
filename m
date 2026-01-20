Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80979407596;
	Tue, 20 Jan 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919721; cv=none; b=pfa/hiwklQNBXjCa440VwDKeOZOe3VUhFYW1mhpPaQ0lu3XCIw7nhOKPiPZnIqmHLMWB/yIQ0+iKIjf3zyoRhHn1b5PpZiZEl5lQrIxXMUaiun5P48fWveniRNFmTGj9vvpQ8CyT6blurQv3lTcp7amqe8C0tMzQdR0BC5hfrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919721; c=relaxed/simple;
	bh=5A46/306RV9Pa9Q4emd1bo4do/aU2G4q4mdG0Pfjn7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAW9HbmiMpvJK0pmeUoo6tnUT1adexfAtoT77015rmxOpXK2hDZzOD8psJoK1Q2K6/RN6JdhBBP1kJEPqqp72h3/FICHi7OJg8xYq0FNS7lk28M41qmhcGQNjrCk55BBDEYV9ukyHc7e4uk5eaYMtDZ+n95MBTiF3wwaaGqKgvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USrkTyz8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USrkTyz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A526C16AAE;
	Tue, 20 Jan 2026 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768919721;
	bh=5A46/306RV9Pa9Q4emd1bo4do/aU2G4q4mdG0Pfjn7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USrkTyz8syD5avt7Ysod72tz8A1Pm3LfInTlDhXZmbLcVzEzwvrZ06r0vPh0AiZTQ
	 co4FEj3/EGWgY+lXG+xkLPpWeC6Nm26StH4fmSBc+qnaCXVu81HG1sJC6wpT91Ugkn
	 ij2RqsoVgUqm2AHOdWFqm6DCM/VoX4rFdLss4GYhRL1wHRPtLxXpcZatLOSFgvLBea
	 nUqOe6xhSkAfWMIJL4EYbtJ1yEX0kOl77yp6dZuC035JH5TbfRrYDG8+gooKv1Xv3Q
	 wHxXtCxOwsyJOvgAzkl7AB6/5QuEB8I8OERwA0HH2VxYEvEfqbxHF6f5UGklyU6Ve4
	 dfzcVEt8k142Q==
Date: Tue, 20 Jan 2026 15:35:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org, zhangsenchuan@eswincomputing.com,
	Shawn Lin <shawn.lin@rock-chips.com>, dlemoal@kernel.org
Subject: Re: [PATCH v3 0/4] PCI: dwc: Rework the error handling of
 dw_pcie_wait_for_link() API
Message-ID: <aW-SpCEPSakHAJ0B@ryzen>
References: <20251230-pci-dwc-suspend-rework-v3-0-40cd485714f5@oss.qualcomm.com>
 <aVezfq-8bTKczYkp@ryzen>
 <mrm7yif2tg7trvsof3jiqbevfldkf7ckkfswtabrnkc4dlgmae@qyp4s23utlid>
 <aV5XI_e3npXHsxk7@ryzen>
 <aWErEbvByGrxu5s9@ryzen>
 <ouygfgehh3evllgcibintuer6euyqrrn3otg3ets3frcd7i5wt@nnyjibcrw6ds>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ouygfgehh3evllgcibintuer6euyqrrn3otg3ets3frcd7i5wt@nnyjibcrw6ds>

On Fri, Jan 16, 2026 at 02:27:39PM +0530, Manivannan Sadhasivam wrote:

(snip)

> > So I don't think that setting the DIRECT_POLCOMP_TO_DETECT bit will
> > help us PCIe endpoint developers to continue with the workflow where we
> > can simply do a rescan on the host after starting the link training on
> > the EP.
> >
> > Back to finding another alternative. Kconfig? module param? Suggestions?
> > 
> 
> I don't like the user to control this behavior as it is just how the link
> behaves. Maybe we can allow the link to stay in POLL and print out a different
> message, and still return -ENODEV? Like,
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index c2dfadc53d04..21ce206f359b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -774,6 +774,14 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>                     ltssm == DW_PCIE_LTSSM_DETECT_ACT) {
>                         dev_info(pci->dev, "Device not found\n");
>                         return -ENODEV;
> +               /*
> +                * If the link is in POLL.Compliance state, then the device is
> +                * found to be connected to the bus, but it is not active i.e.,
> +                * the device firmware might not yet initialized.
> +                */
> +               } else if (ltssm == DW_PCIE_LTSSM_POLL_COMPLIANCE) {
> +                       dev_info(pci->dev, "Device found, but not active\n");
> +                       return -ENODEV;
>                 }
>  
>                 dev_err(pci->dev, "Link failed to come up. LTSSM: %s\n",


Seems like an excellent idea to me!

I tested it, and it works, thank you.


Kind regards,
Niklas
