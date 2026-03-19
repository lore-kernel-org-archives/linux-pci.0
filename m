Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A1379999;
	Thu, 19 Mar 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914991; cv=none; b=BikOzasHSftnOUqLe5mF90FZvgakqVBgy2jl1voZEaTH1C6SlZbBlESWuN8V00ReYdXB0n5jSry4smS4mrc7isvF7EAvYPy1FvjgmzAaXe+bkKwfQmEJgTYnyy1wdRtPaBihScVMR9zDTSt4rWrtJEBkdcTZ2fxGIbNcGk5IwqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914991; c=relaxed/simple;
	bh=FDsasxUAcM2aks4WAPlnuBI/DJ39aq2QyDS6b0IaW0c=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=gTDPKf5I+K4mI344ydAY/Ltd5FNMAYEyeE3WxClkUo8pbqBFNUAKaUb+FKWO2P4N1PJEjhyEo3XLwk8LavFQLvZCmoyz2Z+WqGx1HKZwAbeOm8v2jeZ5OG95gm7zrravT4bRgjzdqGNbQp4iyZOTkBAlfoVrXyVGAEAnycuT4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=JB/zsiTo; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="JB/zsiTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=pl6+j3qZ6SPny0RsBwu35gcI0En9PkQfw
	3D0Ql0HKkA=; b=JB/zsiToGsDec65b0by5RGbK2X0wDr3EoNxR7MNjJWWpJwH4u
	gTXaZSuUDYbyoH8wckvl7kAxSACrU/OaCEp+wU04Gu0Vh2hEQJqIxIRVDZilH8Zy
	eY6z4UlCdlFFJ6KqPqlg0c5QiqCKaAVPrwW5G0PaPRIzEzxSog35/2K5t4=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAHtSSRy7tpApIBAA--.1409S2;
	Thu, 19 Mar 2026 18:10:25 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 3/4] dt-bindings: PCI: Add UltraRISC DP1000 PCIe
 controller
From: Jia Wang <wangjia@ultrarisc.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jia Wang <wangjia@ultrarisc.com>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>
In-Reply-To: <177364929764.1046214.13699651740074271027.robh@kernel.org>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
 <20260316-ultrarisc-pcie-v1-3-ef2946ede698@ultrarisc.com>
 <177364929764.1046214.13699651740074271027.robh@kernel.org>
Date: Thu, 19 Mar 2026 18:09:35 +0800
Message-Id: <177391497590.2824357.9030407054711939789.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773914976; l=2688;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=FDsasxUAcM2aks4WAPlnuBI/DJ39aq2QyDS6b0IaW0c=;
 b=gOkDhGLqisBONr0ktCvrVB+i65X0cLepvAmTgmCLMkQRoh5JJ3pdv3Zmoz8taqeI1a1NRgmWH
 t58CiJrwyh3DUheOizd8l87ZVSPR8frdFrJWSL9bdbSSVZg6+UvFfKa
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAHtSSRy7tpApIBAA--.1409S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFy8Cr1fZFWfWr4UuF4Uurg_yoW5Xw1fp3
	y2krn3tFWvvr13Ww4fta4xK3WrXrn7Aay3tF4DGr17tF15u3Wrt39xKw15uF1DGw48ZFy3
	Ar1a9w4xG3y2yaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQALEWm7kgkAFQABsG

On 2026-03-16 03:21 -0500, Rob Herring (Arm) wrote:
> 
> On Mon, 16 Mar 2026 15:06:59 +0800, Jia Wang wrote:
> > Add UltraRISC DP1000 SoC PCIe controller devicetree bindings.
> > 
> > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > ---
> >  .../bindings/pci/ultrarisc,dp1000-pcie.yaml        | 108 +++++++++++++++++++++
> >  1 file changed, 108 insertions(+)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml:26:7: [warning] wrong indentation: expected 4 but found 6 (indentation)
> ./Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml:38:19: [error] syntax error: mapping values are not allowed here (syntax)
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml: ignoring, error parsing file
> make[2]: *** Deleting file 'Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.example.dts'
> Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml:38:19: mapping values are not allowed here
> make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.example.dts] Error 1
> make[2]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/pci/ultrarisc,dp1000-pcie.yaml:38:19: mapping values are not allowed here
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1606: dt_binding_check] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.kernel.org/project/devicetree/patch/20260316-ultrarisc-pcie-v1-3-ef2946ede698@ultrarisc.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
>
Thanks for the report.

I’ve re-run `make dt_binding_check` locally with updated `yamllint` and
`dtschema`, and I can reproduce the issues you pointed out.

I will fix the indentation and correct the syntax error, re-validate the
schema using the full `dt_binding_check`, and send a v2.

Thanks for the guidance.

Best regards,
Jia 


