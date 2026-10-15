Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7853DB658;
	Thu, 15 Oct 2026 02:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792031713; cv=none; b=sgoBpwa3YhUYp8zZYkbEk/QYErB+CbfvDUNsaXQwI5scHpdrW9PiWHE0iFsjYAwWH3P8Knry93hxkwxDXqdcveOvsbnf7z7wDSUulpqk1zgyIr63bmpsIAH3z4tSeviBmHVX5LfkBYz1X8U4D783lix6r67AehVsRDHVxWt3iqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792031713; c=relaxed/simple;
	bh=yqboJuSFj1MiuZgOPBB633piM82kQ985s72WYweaYT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TkK3Os68WJ5+BWNlZNiLgoY0Ja9Wb4q5eh3FAmv5iJt0y4VtCemMnnwH5n5c+ypFaV0Z9mHjxzlSu+ac2lzCGIiOWgK/75/Sn3xX8c21fHkHIpZEPHgqz96eyYwvWRR3u4Wdvb92EybbIinjd1GAYjEFdEuBCwpD9zs6wMxBGf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=none smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=pe93UWe4; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="pe93UWe4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=c/6W0LBdBU+dTI2matne96lJqD7HP4Hyuh
	pge2Ox2K8=; b=pe93UWe4R2PxYqJgNMsXL/fjQfk6/pAlF2O0O8LoIRbu0AB0X5
	HNJrK5pwRyuF1AQOJvn4KRlLKe1NqchCAZrDFgWfA4MFHxeTh8NlzSUWbl5Y7EH2
	FFHFXx+9+nvIa7X2H+t6BVRsVhBBhqrtjbV99ALy1ZRrxvBDA2z9yd94k=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwCnYwXWO9Bq+BcCAA--.697S2;
	Thu, 15 Oct 2026 10:35:02 +0800 (CST)
From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Frank Li <Frank.Li@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU setup
Date: Thu, 15 Oct 2026 10:34:59 +0800
Message-Id: <20261015023459.125468-1-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <as89A9X9wAHJ-dIR@ryzen>
References: <20260905025635.211390-1-zhangxincheng@ultrarisc.com> <20260905025635.211390-2-zhangxincheng@ultrarisc.com> <as89A9X9wAHJ-dIR@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCnYwXWO9Bq+BcCAA--.697S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4DAF45AryUWF1xGr1DAwb_yoWDXwcEka
	4DKw4Ikw1DJa9rA3WfKF45WrZ29a9I9rn5JrWDX397G3yFvFnxXrZ5Grsay3Z5Ja4xCr45
	Kr98J3yxKwnIyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbhAYjsxI4VWkKwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z2
	80aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ec7CjxVAajcxG14v26r1j6r
	4UMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUgSfODUUUU
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQAGDGq8sakAAwASsU

Hi Niklas,

On Wed, Oct 14, 2026 at 10:27:57AM +0200, Niklas Cassel wrote:
> Sorry for commenting on this patch after it was accepted.
>
> But... since this behavior is intrinsic to the DWC controller, rather than
> being SoC specific... Why bother creating a flag for it?
>
> Is there a reason why this can't just be a simple:
>
> if (atu.parent_bus_addr == atu.pci_addr)
> 	continue;

Thanks for pointing this out.

I added the flag because I had only tested no-match pass-through on DP1000.
But you are right that this is DWC behavior, not SoC-specific, and comparing
the two addresses is enough to tell whether translation is needed.

Since the series has already been applied, I will send a follow-up patch
that skips MEM outbound iATU programming when atu.parent_bus_addr is equal
to atu.pci_addr, and removes bypass_ob_mem_iatu and the UltraRISC-specific
setting. CFG and I/O accesses, as well as non-identity-mapped MEM ranges,
will continue to use outbound iATU windows.

Thanks,
Xincheng

