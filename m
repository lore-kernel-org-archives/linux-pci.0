Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245218;
	b=fQRyybotaQ54/pFoNtGJPsV3v13A8J2kDpcJMBmNlECweOEDgMcl/c6KZ5Gr4xryLUxI
	 bLkS1ejbijSF38FsYnIqtbnsIXSkRl0FqEgkoGkDwOt0DD9OJUecmLRcOmYTTdtUhnEXA
	 RMoXgsAl1girWaaqYN4WNEiAVmSgI27+3xy7Wp0O65AhTZsk+M8XQp4E8dW0p94YElLDN
	 zYjW/eaSyNiOunTLVS1DPEtynnbN5NUHixdPjcofaA3dv1hQCu4MFTBDvOkGQpYkeDSKI
	 BRLhcGyfJyo/Q3DcyjCZER03ykFfayZbgSAiRTWQdk/7pmlmUe5B2o3+Vqh3vKvdKiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245218;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=Q6YeiifV/84lte1fx4gsumMxZCBv00tuDX4EIGhZpJU=;
	b=ln34bbb5zX5xdaMb7IXIOq3nmrq5yUfw8pbCSKYOam2SI5B/M4ctrHYBHmg5WQN4Ot5q
	 OxT67RDwxcOu9zdJNTtH4VK0etOmcFDp5ZECoY9UnbnpgSb+iox9mSdzQZqdE5aGeK4LK
	 ZP3HFXHSZREAR3wih2sDE1QTJdJOBzY3Y0xDuz2vHmpw5QR7jYPooV/wXaT44+QeTTH6N
	 V+ZgaKa5dTj+kJuGHg3QIOmQZ9OP2QO0sDRGT7BcAmnwcDjEwRttGSz53eMvkcNKGYW21
	 4rf0S7JdoZRedUj14Z9Or3aF7UEmXEWv3u3SNZZwGnoakDx3D0vp82eQtyAuQjMnVhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1401606A31C;
	Thu, 29 Oct 2026 03:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1401606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.172])
	by gateway (Coremail) with SMTP id _____8AxdvAdwOJqHFQaAA--.10538S3;
	Thu, 29 Oct 2026 11:40:13 +0800 (CST)
Received: from ubuntu.loongson.cn (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJBxrM4bwOJqfRAxAA--.11881S2;
	Thu, 29 Oct 2026 11:40:11 +0800 (CST)
From: wuqianhai@loongson.cn
To: helgaas@kernel.org
Cc: tzimmermann@suse.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/VGA: Fix boot device detection after framebuffer relocation
Date: Thu, 29 Oct 2026 11:39:14 +0800
Message-Id: <20261029033914.978276-1-wuqianhai@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028231514.GA577494@bhelgaas>
References: <20261028231514.GA577494@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxrM4bwOJqfRAxAA--.11881S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFyUtw1fuFy8XFyxJw1kJFc_yoWkKFb_ua
	yxAasrGr18Way0ka4kK3WrAw4xu3y0vrWrGan7JrySgFyktFn2g3WSkw1fZr1xG3yUtF4D
	KFWDtF13Z34fuosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb4kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rVAKj4
	xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWU
	JVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2sXoUUUUU

Hi Bjorn,

Thanks for the detailed analysis.

You're right that screen_info_fixup_lfb()/screen_info_apply_fixups()
stores a PCI bus address in screen_info_lfb_res_start and compares it
with the CPU address in pdev->resource[].start, which is broken on
systems where bus and CPU addresses differ.

On LoongArch, though, bus and CPU addresses are identical: with modern
firmware, acpi_prepare_root_resources() takes the PCIH path and leaves
the window offset at 0 (see commit 49f33840dcc9).  So the existing
screen_info_apply_fixups() works correctly for LoongArch, and the
address-space confusion you describe does not trigger there.

I've sent a v2 that:
- enables vga_is_firmware_default() for LoongArch,
- restricts the screen_info_apply_fixups() call to LoongArch so x86 and
  other architectures are unaffected,
- makes VGA_ARB select SYSFB on LoongArch to avoid the undefined
  reference when CONFIG_SCREEN_INFO is not set.

The general bus != CPU problem in screen_info_pci.c is still worth
fixing for ARM and friends, but I'd rather keep that separate from this
LoongArch enablement.  Happy to help with that follow-up if useful.

Regards,
wuqianhai

