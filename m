Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7633336495E;
	Wed,  8 Apr 2026 06:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775630622; cv=none; b=KJtiC4PG6suctlbBrWvBZnReo/LiHOFOcFrQGiTytwmWu0NBBE8yBJWKYb/hamnqBe98lQNeeqmi0innguaVJr2+IJKi4991grLjohAy7kG2tRQHEfo3qqUy2Y3Z/mdqqHOky0ru3RQA8VcI52sAIMHp7KJ2padEEKHxyc6XS/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775630622; c=relaxed/simple;
	bh=2hdbV6/k/0D5ZPlOLiZgFhv0ho2ZF/B1xroBTN/yRgk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=n9BptAtc2yRlcJmMeZR7E1g5cxHDrXqTLZas7qrkoKPZpQoVWmnDkZThA4HSqB3Kryyck9ZWA4nfzIuDG0yr3DnKABF5RxH5MBFcXpoJIr7eduP2o6nBv4Hc14zTaieOXlKQy0ePN7E9Q/NCgt0G1VCHvPnjgYjC71S960in49I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=EYx66LlO; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="EYx66LlO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=hS/w51EPTbNWGcs80cYtMs7ssnkfGD2zW
	cF8zT6Qlug=; b=EYx66LlOSiSbVcNq+lzEc/OAjRVJuNtAUKk7AwEPC6FSeIXe4
	6R7SyI3SyLf5+vxbvQ9GxCHIWsPlDfcNaglNuMeHG5CTRpuejyzd3vKPN6931lT8
	sNct9yA+r8tkp6KAq3I/iJ/XqmOHX4tsVDjkAya1CVulsbmKVJ5hrCq2P8=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwAnYUI1+dVpSq0BAA--.1022S2;
	Wed, 08 Apr 2026 14:44:06 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/4] dt-bindings: PCI: Add UltraRISC DP1000 PCIe
 controller
From: Jia Wang <wangjia@ultrarisc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jia Wang <wangjia@ultrarisc.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Xincheng Zhang <zhangxincheng@ultrarisc.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <13907c0e-0502-413d-b54d-4e903f5c781e@kernel.org>
References: <20260407-ultrarisc-pcie-v2-0-2aa2a19a7fb3@ultrarisc.com>
 <20260407-ultrarisc-pcie-v2-3-2aa2a19a7fb3@ultrarisc.com>
 <20260407-uptight-tody-of-weather-ae1e35@quoll>
 <177561928084.2918127.18218641774926914517.b4-reply@b4>
 <13907c0e-0502-413d-b54d-4e903f5c781e@kernel.org>
Date: Wed, 08 Apr 2026 14:43:19 +0800
Message-Id: <177563059910.3194559.10112671473525736823.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775630599; l=804;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=2hdbV6/k/0D5ZPlOLiZgFhv0ho2ZF/B1xroBTN/yRgk=;
 b=FwDWsOzDS/KbcQdL6O8kYj37FxAVDdJiioU3JgfIuqk4Y2qDTOKjWi/9k1iWNJJCVb+1lm4DQ
 o9KLacoeFpiCi1XqVroJ2MYAatf4HHhjIytgQd8XRGfBgLmZrQFD0Ig
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwAnYUI1+dVpSq0BAA--.1022S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1DuF45Ww1UuF1DXrW3trb_yoW3Xrg_AF
	1jvw1Dur17XFZ8Wws5tF4kZ3ZIk34Duws3X3ykuF9rXwn0yry5ur90kryfJ39xJa1xKF1r
	ua10q3W5uF9xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbT8FF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRRBT5DUUUU
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQALEWnV0LsAEAAAsc

On 2026-04-08 08:28 +0200, Krzysztof Kozlowski wrote:
> On 08/04/2026 05:34, Jia Wang wrote:
> >>> +  max-link-speed:
> >>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>> +    const: 4
> >>
> >> If const then deducible from the compatible. Drop the property.
> >>
> > 
> > Will replace `const: 4` with `maximum: 4` in v3.
> 
> Why? Wasn't maximum link speed fixed to 4?
>

Just to make sure I fully understand: since the maximum link speed is a
fixed hardware property and is implied by the compatible, we should drop
the `max-link-speed` property from the binding.

In that case, should I set `pci->max_link_speed = 4` in the driver during
probe? I want to make sure this is the correct way to handle it.
 
> 
> Best regards,
> Krzysztof
> 

Best regards,
Jia Wang


