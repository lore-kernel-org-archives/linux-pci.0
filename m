Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3398C3AF67F;
	Thu, 19 Mar 2026 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773912514; cv=none; b=iAzrCCjjGMDGAIq2CVKiF2rNr+hSlspVvyq2SeF3KGxVKRwqzJK0PhnKedzZNBzmNKrVmVnw9+n5UXrW7jagUMJS+EPXNzH4KuA+s/8L6ywAXN1mjB8h+NfT7W10U2UvIs+pPGj2vKnqA14yWZ3ZQjukaygxnDq9TrV2qZCdADQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773912514; c=relaxed/simple;
	bh=HyjOHcX/Kkm5YJCmy7d7XosInvEHySEKxeiBw8BnaXg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JKHPK2cISYV5KW2P8TuyL1DNVwFRNNXDiIzHRgmnVoYFc8cIvGcPv+AJfadqcQyK722W/gQRgPHpnHQlwtSxpXAz+C0Lq2VUujSIo4o2c2zVgZ+7gw4sxBZ7JI1GioFhvQY20m7DN9Ucj3LsYTAypF6z6IQQw/Gs+sO3t73TH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=WRlw7WGK; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="WRlw7WGK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	References:Date:Message-Id; bh=Cb2BSk/vS4RMFR/eRi2Mqj3i3NHmiCtlF
	UY132gU2I8=; b=WRlw7WGKELZnkFOU01QftyTjS01XcERQ1b1txIc/w62FXFwAJ
	ZryMbQziFOHCQMEeolsz69lrUoVzYrKm+R9ycdAX/iv51fkafn5hyubTfQchxwlD
	AmnZw7kBmgXyXR7nxTkvn1ulYoXSDmQBseOTj/9j26ODpjKL7gB9K9tg5U=
Received: from [127.0.0.1] (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDHJSXRwbtpGZEBAA--.1354S2;
	Thu, 19 Mar 2026 17:28:50 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] riscv: add UltraRISC SoC family Kconfig support
From: Jia Wang <wangjia@ultrarisc.com>
To: Conor Dooley <conor@kernel.org>
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
In-Reply-To: <20260317-renewably-unroasted-45c63bd0c95e@spud>
References: <20260316-ultrarisc-pcie-v1-0-ef2946ede698@ultrarisc.com>
 <20260316-ultrarisc-pcie-v1-1-ef2946ede698@ultrarisc.com>
 <20260316-powdery-unbundle-b1166d13f53b@spud>
 <177372998464.49340.13796019002628537253.b4-reply@b4>
 <20260317-renewably-unroasted-45c63bd0c95e@spud>
Date: Thu, 19 Mar 2026 17:28:00 +0800
Message-Id: <177391248056.2824357.15290555460185288415.b4-reply@b4>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773912480; l=2034;
 i=wangjia@ultrarisc.com; s=20260309; h=from:subject:message-id;
 bh=HyjOHcX/Kkm5YJCmy7d7XosInvEHySEKxeiBw8BnaXg=;
 b=dbe+ZDKMOUTE9vOXUKrpgdEyvkA1mgrYsYg8s3SHQDX1plXNscuNUdFD8b7GjSJFBn8zWvxmP
 vxEd7WcNCwRCa15+4yAhlK8NFGig6QLVYgykFI8QPDDzCaCq0ImoLlZ
X-Developer-Key: i=wangjia@ultrarisc.com; a=ed25519;
 pk=XvYkrelqJIIzobY7j+nIg8rsfv5kzaOzuc1UPhd087U=
X-CM-TRANSID:AQAAfwDHJSXRwbtpGZEBAA--.1354S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1UKw4xZF15XFy7ZF4xWFg_yoW8Cw15pF
	s5CF1YkFs8Jr1fAFZIqw45Wr4jkrsakr45XwnxWw18AFZ0krySkryktw15u3WUurZ5Jr1F
	vF1ruasxZr15Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pzdqwylld63zxwud2x1vfou0bp/1tbiAQAKEWm6QIkAGQACsb

On 2026-03-17 13:02 +0000, Conor Dooley wrote:
> On Tue, Mar 17, 2026 at 02:46:24PM +0800, Jia Wang wrote:
> > On 2026-03-16 14:39 +0000, Conor Dooley wrote:
> > > On Mon, Mar 16, 2026 at 03:06:57PM +0800, Jia Wang wrote:
> > > > The first SoC in the UltraRISC series is UR-DP1000, containing octa
> > > > UltraRISC C100 cores.
> > > > 
> > > > Signed-off-by: Jia Wang <wangjia@ultrarisc.com>
> > > > ---
> > > >  arch/riscv/Kconfig.socs | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > > > index d621b85dd63b..f49d3ccaacde 100644
> > > > --- a/arch/riscv/Kconfig.socs
> > > > +++ b/arch/riscv/Kconfig.socs
> > > > @@ -84,6 +84,16 @@ config ARCH_THEAD
> > > >  	help
> > > >  	  This enables support for the RISC-V based T-HEAD SoCs.
> > > >  
> > > > +config ARCH_ULTRARISC
> > > > +	bool "UltraRISC RISC-V SoCs"
> > > > +	depends on MMU && !XIP_KERNEL
> > > 
> > > Why do you depend on "MMU && !XIP_KERNEL"?
> > >
> > Hi Conor,
> > 
> > Thanks for the review.
> > 
> > The dependency on "MMU" was added conservatively, but the DP1000 hardware
> > does not strictly require MMU. I will remove this dependency in the
> > next version of the patch.
> > 
> > The "!XIP_KERNEL" dependency is retained because the platform does not
> > support executing the kernel directly from storage, so the kernel
> > must be loaded into RAM before execution.
> 
> I would imagine the reason these are here is because you copied this
> from one of the other entries. They have "depends on MMU && !XIP_KERNEL"
> is because they have errata that require alternatives to resolve, and
> alternatives require those conditions. IMO you should remove these entirely,
> especially since XIP_KERNEL is about to be removed for riscv soon
> anyway.
Thanks for the clarification.

I will remove the entire "depends on MMU && !XIP_KERNEL" line in the next
revision.

Thanks again for the guidance.

Best regards,
Jia

