Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A997274B55
	for <linux-pci@vger.kernel.org>; Fri, 23 Jan 2026 07:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769154683; cv=none; b=dzeQmt3/Vv5HrVPj1aA30kALfpKa7dcXvmKadEh3+g8XIAW45cSYBvdiTYG3kZ0LT5G5y1/YwSTRNynY5zF7utnbcvbw/yY5zxjbF0aq3yKzgZ7ZKrSKNZNKCtlunPyw9oHOrTxVBC4VX4cfnlheVR8E0Zp6KltP/Iv4QQqVejI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769154683; c=relaxed/simple;
	bh=ucSInyu8ioDMAsJedgP4ZKmImvxy5NuSNnj5zHxLezs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXRwys0d0EdSoGrBb5CeI/ow2OYktwXsCKTDzzW6pmaXz1XpRj5GNnBuVuU0bopBOpXg9WZlIT/VO9VVqphPy/BWCA9jo1OSh14hb8wVz761pl6nF1b0EtHOMjTc5XvGWLINjN8YMhT1hJFs7vgTZOlxGFP+iEzEPR4PDmiY0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA9ApAFL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA9ApAFL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A15DC4CEF1;
	Fri, 23 Jan 2026 07:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769154683;
	bh=ucSInyu8ioDMAsJedgP4ZKmImvxy5NuSNnj5zHxLezs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AA9ApAFLgwZCOkIWN3+J8/bp5n0beq+anBlhNFD431EshkrjUo+FvV2oMFI/R+5zG
	 3cuM8YQRBMb/6iSWMo8NPTzOXOwr12BYkI+DVPo2yNDkre6SrnIDbE0oRGvKZotq8Q
	 FYcDDuBm7vohVCKiJGpaUFDi2HGe7PSX449OtyTa/vmHSWk3hIKWw/w15MGzqPW/GW
	 plbtOIn55gTi8C7dfEsqOVWMn75DBfYdhNbQuhjRNNm9cnSF36KmKZQFQ0VQU/Vv2t
	 sIwSIwVL4GYbEU12hagdIjLCvrnJJBN0gT2IRawmBgI1ruxReaVawAirU0Ihsr3A9w
	 EfCWL5zIT/tMg==
Date: Fri, 23 Jan 2026 08:51:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@nxp.com>, Randolph Lin <randolph@andestech.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Charles Mirabile <cmirabil@redhat.com>, tim609@andestech.com,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 2/4] PCI: dwc: Improve msg_atu_index error handling
Message-ID: <aXModSuRJ5taXjTU@ryzen>
References: <20260122222914.523238-6-cassel@kernel.org>
 <20260122222914.523238-8-cassel@kernel.org>
 <1fc62af3-4b97-46b0-9ace-bcf2d5e6fc7f@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fc62af3-4b97-46b0-9ace-bcf2d5e6fc7f@rock-chips.com>

On Fri, Jan 23, 2026 at 10:07:31AM +0800, Shawn Lin wrote:
> 在 2026/01/23 星期五 6:29, Niklas Cassel 写道:
> > Only try to dedicate an outbound iATU to MSG TLP if use_atu_msg is set.
> > If use_atu_msg is not set, it is completely useless to bump the index.
> > 
> > Additionally, if use_atu_msg is set, and there is no available outbound
> > iatu available, return an error.
> > 
> 
> Nit: there is no outbound iATU available....
> 
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Thank you, I will wait to send V3 until Maciej has had time to test.


Kind regards,
Niklas
