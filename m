Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521B376BD6;
	Wed, 25 Mar 2026 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774424565; cv=none; b=tF2wjTuHPtDoSajv4/csyWI98oh9hf8mfchnmNzvtNALjrmGGJK5yr2ybco+71y+L15+Zbl+assehL7DerJthgHNuwn38obmIUQdY0BXb5sQGcYDdOA0XVjFTDLLkx7Uv7cFvxc4XAbKdObNE8sQ7kzHygHwZxiADH3MGrjm3Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774424565; c=relaxed/simple;
	bh=ZxDBul7Hmjz6gCpE7EFMz6ACkUdhmElHE5PzlYRkBRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LzJbpX5ffA86FD2PbzbLbyh4P2w4B3Ka32c1FyNfVYLz4wacHzPDpx9ULpqSSa9L8fjfjq5MQBv4HCpZNe8v+ZJhGHlKIXyxUHViBFwDrOfReYSKoGLKzIpR5vJ+r4bmer05sa4iE3gt1GWdNTUaJ/zLKnCpfhUTM3fsu5vHzbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvEqC5bH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvEqC5bH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A209C4CEF7;
	Wed, 25 Mar 2026 07:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774424564;
	bh=ZxDBul7Hmjz6gCpE7EFMz6ACkUdhmElHE5PzlYRkBRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SvEqC5bHI8Yjs9c7YAl+9Sxku/p+zpeK2e9kbQGc+CHeuArDgR5lhwPtekY9i09Ax
	 kydjry1NWZ6aHnxYBWwIEuNrpAtC4D2t42nhaZpg6cqeC1kssaWFFu/LZHe3oAspZm
	 r8IhPUw8Lzeq4lstG2ePSliWe7uYws4gdW5Z0R6EKnPlg4nyLPkACoVbi/x3EpFsis
	 ZpR0Yrf/3xg+s0XUH3ndbY9jGJQd5WT9Ubt6n/AL3JMCIgI6eGWeakp+ssyuUx6DXO
	 hCIK0q4WJAPjc/ijjSl/flVbR3GT/JrNPEncGMkLYywbVu6ZimZ+zKUGNF6IN9vE54
	 cKkKGkM0ubRpQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Marc
 Zyngier <maz@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Inochi Amaoto <inochiama@gmail.com>, Nam Cao <namcao@linutronix.de>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>, Randy Dunlap
 <rdunlap@infradead.org>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>, oliver.yang@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/MSI: Update MSI-X irq domain hwsize
In-Reply-To: <fe47586d-688f-409c-95b5-d2cc54871f3a@linux.alibaba.com>
References: <20260324014754.4973-1-kanie@linux.alibaba.com>
 <20260324014754.4973-3-kanie@linux.alibaba.com> <87mrzxgwfs.ffs@tglx>
 <fe47586d-688f-409c-95b5-d2cc54871f3a@linux.alibaba.com>
Date: Wed, 25 Mar 2026 08:42:40 +0100
Message-ID: <87mrzwfj7z.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25 2026 at 09:34, Guixin Liu wrote:
> =E5=9C=A8 2026/3/24 21:59, Thomas Gleixner =E5=86=99=E9=81=93:
>> On Tue, Mar 24 2026 at 09:47, Guixin Liu wrote:
>>> After the upper-layer driver removes the device and before the next
>>> probe, events such as firmware updates may increase the number of
>>> interrupts supported by the device. However, the irq_domain still
>>> retains the old hwsize, which causes subsequent interrupt allocation
>>> failures. Update hwsize during MSI-X device domain setup to fix this
>>> issue.
>> When a device is removed then the corresponding struct device is torn
>> down, which implies that the device domain is freed as well. So how can
>> this end up with the old state on the next probe?
>
> Hi, My description was a bit ambiguous. The msi_device_data_release()
> path to remove the irq_domain is only triggered when the device is
> removed at the PCI layer. If only the upper-layer driver unbinds,
> this path will not be reached.

What's an upper-layer driver? Please be precise.

I assume you are talking about the device driver itself. Right, the
unbind of the driver won't remove the domain. But there is no real good
reason for keeping it around at that point.

So the straight forward solution is to free the MSI domain when the
driver shuts down and tears the MSI interrupts down.

Thanks,

        tglx


