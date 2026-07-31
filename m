Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80168341057;
	Fri, 31 Jul 2026 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491204; cv=none; b=dMKXqv2STpwQhBCUATvl3oydSRb5u9+yxqhGjIXbAfdK2d6UlbpuUNyMX93Zk1H2K7sWAeClIfY7VIVMrbooaPVHsIdWW+jA/pzM7NiNU2crlf0qS8Eo1h1zMtTde7p+Tbt+var+ev23jmP2jxQygCILUGKO9V0CyWQhyTv6BpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491204; c=relaxed/simple;
	bh=mJhtUGaggvG2LDhBBwJE4HaathghG0qDQvxx+4OCzUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqvOihQDnxIrbZ08PtRmnkAbjb1dCAPjP9hF338mI3qRmBgS7m/SiCuPyUREiJ8/FsaCXEj3/6IhW8le1bkK8PK6ETZ+bTEciD94egAKoMeqKSszW97PoKAJdjSBVuUZaNSOJHMH84Nn1hgmwtRxvWuyJF4Ooz46SKyLpC6iPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS3/YcsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS3/YcsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5401F000E9;
	Fri, 31 Jul 2026 09:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785491203;
	bh=7o8o99tUrtdy7fgnRD9H5JTGaw8ZIZeDzMg7wr5o6zA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iS3/YcsA/lp6usbnF9ut2MlqrNSD/2R+txHymleM3mQxqI50HycBp2pTX3TRjkD5Z
	 EZ3YpVrix+c9bTlblKxgVyaipXe7d++PTtpY7L1+6f9HMDRiezIYMTn0E0s9vCniXR
	 +DiD5M3u8a82/PDxBC8pm2wntHQYrUqpTc2Qmrd5Ux9lOa5un/9AEXNYgndvZv6lNy
	 p/BfgKedwVsWYCS4Yq8VdKWI2Xp6UOUKA6PhLdHl4joxUf10Cttf8f6lGRuwSdU75P
	 /AbA8wyVgf4Ga+dcldznvlShGcDXtXHvf3uslQhE5sqBtNE1N7MF52Ly8DigpjY9lh
	 OyKLmhCCTR/Fw==
Date: Fri, 31 Jul 2026 11:46:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rahul Samana <rahul.samana@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	quic_anubhavg@quicinc.com
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
Message-ID: <20260731-first-righteous-bear-dd72ed@quoll>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>

On Mon, Jul 27, 2026 at 09:15:01PM +0530, Rahul Samana wrote:
> QCC2072 can be used on M.2 E-key cards where the card power resources are
> described by the pcie-m2-e-connector node. In that setup, the M.2 power
> sequencing provider creates the Bluetooth serdev child after matching the
> QCC2072 PCI function.
> 
> Integrated non-M.2 designs need board-specific power resources. Document
> only the compatible for now and leave those properties to be added with
> matching driver support.
> 
> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
> controllers connected over UART.
> 
> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>

NAK, exactly same comments as before.

Nothing got improved, although what is weird - original SoB is gone, so
this is legally dubious work.

Best regards,
Krzysztof

