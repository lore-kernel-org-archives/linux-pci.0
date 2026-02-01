Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4D1C549F;
	Sun,  1 Feb 2026 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769983196; cv=none; b=VCb2K3o8MHZTirkmqGtFYMi5Tg2ITCmgoVkQoUNasuMEQNdvW5ITu6R5DY6EZNmOPozxG8Xpe9WAQFWfYMDDTrKzIEBQ40YP+Xv202M9DzZZWuAFGb1xJr4sUINd/Tf0kMPdWRpMdg5nHeAIFYO6ULpi0ovfYyivu9KOLd9hEqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769983196; c=relaxed/simple;
	bh=nwNCfCy2+if2Xqeil/vmYXf8W1NhA8yq0rv6pHKBrSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iagYhjsCtqV6CnA5/BxvgXm1s8vCABEy0gxQR4ZXbMHVez8m5d6cTIFO9yRS9sWpNdAss0Bn2qB80MYfV+oW1ZMj7iTMciLM7Ilzj4Vu8y5dOkKyDEaavEhJoWwUu8onAvUKx8LS2AOWgUrZiltIx8ZNQoXTc5wJ1SyYuXjr+8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZ55KXEi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZ55KXEi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB87EC4CEF7;
	Sun,  1 Feb 2026 21:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769983195;
	bh=nwNCfCy2+if2Xqeil/vmYXf8W1NhA8yq0rv6pHKBrSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZ55KXEi8hcUxUgu6bhh0qs5Md6Cbu4hrdReoTvTQUcTOmbjVYZPDZsTJ1haT0ScY
	 37I6ADunxaz61lQXHGlB52KryXo1BrJabJq1+QRoMNyx5a1MKKuYaegIaKX6/S/GWa
	 Qn6jP8JFE93zJlUAlX64cbjd9Bg6MTJ2x/rmTo5dvR5ZsfFKCPu/3q5IrD7OA9CBmA
	 E90TR/BRHhS5++dPyrT1EOufCF7LCrKtpceeVc+/Q9hKl8BeDKq5jiKkk3YapVrqHA
	 oCthDqCiHFvqoA+R+49JKydQKkR+6Dhn+Ci/nv3A+SR8GhoJaEks8mtY+hcVHY7yHH
	 JfwaS2bCqltUw==
Date: Sun, 1 Feb 2026 22:59:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, jingoohan1@gmail.com,
	lpieralisi@kernel.org, robh@kernel.org, Frank.Li@nxp.com,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: endpoint: Document pci_epc_set_bar() caller
 ownership and lifetime rules
Message-ID: <aX_M1rbIkNaPcVJd@ryzen>
References: <20260131133655.218018-1-den@valinux.co.jp>
 <20260131133655.218018-4-den@valinux.co.jp>
 <aX4y3txKcYmb-kE3@fedora>
 <4erlj426nvmilwfdq5e63ojiqecomcpj35nvmiyw2p5mvifwlt@yspmfxrzmxei>
 <aX_HfpBoQX4j7mag@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aX_HfpBoQX4j7mag@ryzen>

On Sun, Feb 01, 2026 at 10:37:08PM +0100, Niklas Cassel wrote:
> 
> Considering that we probably want to support in place updates after all...
> 
> I guess we probably only need patch 1/3 in this series, plus another
> patch that makes sure that we call dw_pcie_ep_clear_ib_maps() unconditionally?
> 
> I still don't like that dw_pcie_ep_clear_ib_maps() will be called
> unconditionally, but I don't see any other way to support in place updates...

Perhaps just add a comment above the unconditonal call to
dw_pcie_ep_clear_ib_maps() which explains why the call is unconditional
(i.e. it has to be unconditional in order to support in place updates).


Kind regards,
Niklas
