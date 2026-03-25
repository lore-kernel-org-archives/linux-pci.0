Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9113D9041;
	Wed, 25 Mar 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447140; cv=none; b=MqN102JArBlcNkcigV6269046dxh8Ymwex4/d2MRqvhWD+eIIHFYmK/v3z4f/+TqUPcIgrMF2DuOrMd3QOGtF1fz072kIH6QUO/QFghhST5h93yHGCVSJ+GipmLXTjcWGTfCkkPA3olMYJNM4riAODU497GroD0PAoVKO97Z5cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447140; c=relaxed/simple;
	bh=iBXTtoCVkiMKfYdJoaHWdSKD6H4x5bFxU9T4HSOOFAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p+86e+BLoqD3BkeSW/620IG0VBMCpvhw8R8KTnML6h0F77AyggHsX6/KnJsEHGhUpGTjkB5BO8lUwnQ77ruOT+ziOlVm/6fiqS5pofObFbnGCRu087f3yruxNU5WUMcotiJUUJv28SkDD2S2NfeMuarL5D/kbesfwG9RlMg5w7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1DuRrLw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1DuRrLw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA4EC2BCB0;
	Wed, 25 Mar 2026 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774447140;
	bh=iBXTtoCVkiMKfYdJoaHWdSKD6H4x5bFxU9T4HSOOFAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U1DuRrLwmq8zTiOUZERzyb9ayENrQ9sKLV/17JMfVl18FE0FGgg6kBumXEJIaydKv
	 kdaLYl7KAZwLIzmiSBMm5tISjr6kSq6rKHKGAhTirasp94thV2hDweAM94uxqlEKcb
	 6921uV/vdKnY5mKpZ6Hmgk5Y7CBil6jasCYtAPvCu4uSFaAHzLX+BpwEry2wrv3ena
	 p/nm+2XCtrcdZO21eLSKbe7J1SIGDiTlthvd3+cbJkeCOz86ffkiqbepnZxExIyxiW
	 IxsBWSVDQa0KXq3mI5KJ7ke1J8wT4qHkWkmS+Jd8L+M2U9HKC3MwRBOlTtP7KrZfBJ
	 FvPE4OVeIGtpA==
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
In-Reply-To: <d57bf449-cd26-4fbd-891e-77534124e997@linux.alibaba.com>
References: <20260324014754.4973-1-kanie@linux.alibaba.com>
 <20260324014754.4973-3-kanie@linux.alibaba.com> <87mrzxgwfs.ffs@tglx>
 <fe47586d-688f-409c-95b5-d2cc54871f3a@linux.alibaba.com>
 <87mrzwfj7z.ffs@tglx>
 <d57bf449-cd26-4fbd-891e-77534124e997@linux.alibaba.com>
Date: Wed, 25 Mar 2026 14:58:56 +0100
Message-ID: <87h5q4f1sv.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25 2026 at 16:40, Guixin Liu wrote:
> =E5=9C=A8 2026/3/25 15:42, Thomas Gleixner =E5=86=99=E9=81=93:
>> So the straight forward solution is to free the MSI domain when the
>> driver shuts down and tears the MSI interrupts down.
> Yes, I had also considered this aspect before, I will change the scheme=20
> to this, and send another patch, thanks.

Actually none of that is required. When you update the firmware then
just let the PCI core rescan the device. That makes way more sense as
the new firmware might change other config entries as well not only the
MSI ones.

Thanks,

        tglx


