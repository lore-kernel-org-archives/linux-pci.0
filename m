Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71223A8727;
	Wed,  8 Apr 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659298; cv=none; b=fnPNz+wUSrHcSAR1z3n0COWOgDy76DXrpGtfwLGffk5T6urDAFa6tngXe1L7LOQgjnWI+qZFNS/ian400HxNtrup74ajrDEgw7E2dgjdbQM+YrV/cSqs3j/y/kKBAhqcnGeRPgy22AZCkYoN7mIbfyu+25nuNXwwwZs93WY1p2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659298; c=relaxed/simple;
	bh=9Wh+UdZumYojid9BJ79nOukj+1g3DhzrpOCs2lcpkKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgvt0SlVOgedP4Yvli8tz9WZFoiH0uDH6abBZ2xKAmwtW7uhGkaOZITKKa4/5L8cIHd4S4cuSt1nv8oTn5FSb+uK23RRrMprPf2hmXQDw3Yx5ymq10iJQ15PavMuBogeU/EE6UZQWVqaCEIc9BCglfSuU/Jd9mJuydJxBHc71XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQwKaji5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQwKaji5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C72C19421;
	Wed,  8 Apr 2026 14:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775659297;
	bh=9Wh+UdZumYojid9BJ79nOukj+1g3DhzrpOCs2lcpkKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EQwKaji5c3YHl2s49VDS37ys8LeBDbxv9oQj9p9sBr/doYxy3qfFkBVzRmtiZrghv
	 sn6XTXiq7icjPfTa1ZFGQiA7saECcOaeYzagPWM6VI29qIaXXAbQihHtDPRTUIIfri
	 81isnx+S0Aww+2COAyIFjmojnZzJlCjdR6X9nQs83Ueym8nlIj5BgyDTEaWU4s8khv
	 XwA7OGKsr+tkKvgJEGLK7MspRfmMvWjoj2lcO3pcSS7/c/hmmfDIx2ZTAPlcQiQeP9
	 phVXdh4te+zts/zinziolOTr4gZkZ9dCTYYjNRghSM5IG3Is3mYnVPI+DARC8HqVL7
	 qU9lTSU7IreSw==
Date: Wed, 8 Apr 2026 09:41:35 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Han Gao <gaohan@iscas.ac.cn>
Cc: Inochi Amaoto <inochiama@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Zixian Zeng <sycamoremoon376@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Han Gao <rabenda.cn@gmail.com>, linux-kernel@vger.kernel.org,
	sophgo@lists.linux.dev, linux-pci@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: pci: sophgo: Add dma-coherent property
 for SG2042
Message-ID: <177565929503.2148173.1789231317334503357.robh@kernel.org>
References: <20260331171248.973014-1-gaohan@iscas.ac.cn>
 <20260331171248.973014-2-gaohan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331171248.973014-2-gaohan@iscas.ac.cn>


On Wed, 01 Apr 2026 01:12:47 +0800, Han Gao wrote:
> Add dma-coherent as an allowed property in the SG2042 PCIe host
> controller binding. SG2042's PCIe root complexes are cache-coherent
> with the CPU.
> 
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>  .../devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

