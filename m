Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8FC3E5EF6;
	Tue, 30 Jun 2026 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847786; cv=none; b=uTg0qiwcUBZr4iaE7zmG0mJwA/wLrGkwZGYhn2P+ylXKb3EFqoqFCkyYjxj5iQPNT5ok6dfvn39Acn6doxd7+5WSiys2RUY+PpKhMDKzTPH1NONYZsNZjDgZ1Qz4m7Cp3hqppzzuTTtprrX+0H/SLyr0gjgl73L60BA6KNLo5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847786; c=relaxed/simple;
	bh=3Os/xpoBKdv0+KHz/rpKlOGpuT9yJN0TX6YujHN3D5A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f7jfkdUTF3mkoRelQdUusIVcjrWkIGox5GImzZSxKFc2lsClKllxjgihYT2F3/n60RyIJIMPaTaeX5tAjc5VKwUK+Ew4/7wGA3tjF0Pb95PqR489tse54a50BDYHc+ukVP/tW15PrdGZKvMoIwIh7X7pFYwxI6I191vUeSPiUDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2AIDKh5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2AIDKh5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED541F00A3A;
	Tue, 30 Jun 2026 19:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782847785;
	bh=fSzRtKVMoXI7+HHGIKAFEIMBcfBqFTGvZ1qEttKO60E=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=B2AIDKh5vbGFBuOg6hOx6tdHmaWWwzMFzTu6BS2ggeDQO9KhP6owJCRkl8I7qxlBp
	 ECPDP5pOgm2JAt74VH4OUJsu5aYNAg6A/L2YR4PPhxeDLFp1x7CzUZe+9vmhA0sZ9D
	 X6hOdFpOm7x5ck+JJJPQmK702bZ4hCPDZUwjDJRi/n4HMA+zAHqds+WajiGX7r4baJ
	 6dUHPXQvZQGfrKnO3eJt/E/Yk2STTm/M/p7wRnbfKh7xLZao2UAhioaDPK08cWiYe+
	 PTYBhUwha03uTbtfVDRPMKh26Y/L/5Rz9zW+Ohwy0mSSp+hbedhj0eVoz5H+L0Q0CG
	 yFF9nsIzeyLVw==
Date: Tue, 30 Jun 2026 14:29:44 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 7/9] arm64: dts: qcom: shikra: Add PCIe PHY and
 controller nodes
Message-ID: <20260630192944.GA224708@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-shikra-upstream-v1-7-e1a721eb8943@oss.qualcomm.com>

On Wed, Jul 01, 2026 at 12:32:49AM +0530, Sushrut Shree Trivedi wrote:
> Shikra supports single PCIe instance with  5GT/s x1 lane.

s/  / /
s/lane/link/
