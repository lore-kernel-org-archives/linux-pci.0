Received: from ultrarisc.com (unknown [218.76.62.146])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2769548CFC;
	Thu,  3 Sep 2026 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.76.62.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404444; cv=none; b=XALifHUeQmGJVpLpR2g9bbHe4apG9YZLqC3X05Zk3AbPXh2UY+JHZl1KHkTDI6agGFF5N9QdZpF8+R7FnndUjCfbj+sDLUUXm3sMWR4kbLJpgn8pdKV6AO7/DZZS9GbKyYHbvF/gE7XoceCxyybhBtrKC9JAuzZ1Fb/XMHtVrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404444; c=relaxed/simple;
	bh=3onRMap4Ni7w7j4UmdMQoJV3KkV9trPyDpWL3RFfHBA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RJte/tBvdDC0ScGrcQXHHsGBLj12zg3oUYl8hmxcYkcR4qowpmv8C8wn7DvVWpBD5ymJZZ9BFIy7XeXjuwcuBIuHbpaLFEY97rof/ifU1LCn8MV2W1mf+O9yaBr+3+gpb9C/7OOSI2zjyIZAawGpMaQwkJWL/Yoxm2SrVCI8Fyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com; spf=pass smtp.mailfrom=ultrarisc.com; dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b=dKQACgv6; arc=none smtp.client-ip=218.76.62.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ultrarisc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ultrarisc.com header.i=@ultrarisc.com header.b="dKQACgv6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ultrarisc.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=3onRMap4Ni7w7j4UmdMQoJV3KkV9trPyDp
	WL3RFfHBA=; b=dKQACgv6PMxyuI3Rzj4H8jhyqVkc79yAVpWoEMaDLkPymwFh5M
	lnlUE0NgbreWdryc95BlEniBji2nkiZrX6POBnbK3AsZN4t8OYu8yImgrXfGVKZN
	qINUoNPF1NQFY31R7UFbRaYxEaQVbUPwwTW+KCfGrlAejBWTjtBQva9K0=
Received: from leopard.. (unknown [192.168.100.1])
	by localhost.localdomain (Coremail) with SMTP id AQAAfwDnrwbJ4phqKzQAAA--.184S2;
	Thu, 03 Sep 2026 11:00:26 +0800 (CST)
From: Xincheng Zhang <zhangxincheng@ultrarisc.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	wangjia@ultrarisc.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Allow drivers to skip MEM outbound iATU setup
Date: Thu,  3 Sep 2026 11:00:14 +0800
Message-Id: <20260903030014.999880-1-zhangxincheng@ultrarisc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <hwd2taeispmlyz2objfmqghrjftxvjwqzsguyznfnreomjhtue@h3wrfmgfde75>
References: <20260827055448.1818858-1-zhangxincheng@ultrarisc.com> <20260827055448.1818858-2-zhangxincheng@ultrarisc.com> <hwd2taeispmlyz2objfmqghrjftxvjwqzsguyznfnreomjhtue@h3wrfmgfde75>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwDnrwbJ4phqKzQAAA--.184S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw18tryfZw48uF1fXF4Dtwb_yoWktwc_Ca
	4DGay7ta1DWay09rs5KF1ayrZ7C3W7urs3Xr9rJa13G34rZr43ur92gr1ftw17Aa9xtr90
	9ryrX3yUAry2vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbIxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r1q
	6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
	7VUbGQ6JUUUUU==
X-CM-SenderInfo: x2kd0wp0lquxxhqjq3powut2xlvfhudrp/1tbiAQATDGqXx6QALwAAsv

Hi Mani,

On Wed, Sep 02, 2026 at 04:18:58PM +0200, Manivannan Sadhasivam wrote:
> Can you elaborate why the outbound iATU mapping is not required? Are they using
> ECAM or some other custom mapping scheme?

DP1000 is not using ECAM for this controller. Config space accesses still
use the DWC own config access path, so CFG accesses continue to use the
normal DWC outbound iATU programming for CFG0/CFG1.

The bypass is only for host bridge MEM windows. The DP1000 integration has
SoC wrapper address decode for the PCIe MEM apertures described by the
"ranges" property. CPU physical accesses to those MEM apertures are routed
directly as PCIe MEM transactions with the corresponding PCIe bus address,
without consuming outbound iATU windows.

I/O space is also unchanged and still uses an outbound iATU window. So the
new flag only skips generic MEM-window programming; it does not change CFG
or I/O iATU setup.

This direct MEM path has been verified on DP1000 EVB and Titan with large
BAR MMIO read/write tests.

I will make this clearer in v2 by updating the commit messages/comments to
say that the bypass is MEM-only, not ECAM, and that CFG/I/O iATU setup is
unchanged.

Thanks,
Xincheng

