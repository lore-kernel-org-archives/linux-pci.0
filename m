Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B634B410
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769694597; cv=none; b=XDPc5XOVpNG95nWUxgtTztGfHGExKrNTtNNN9MZacvAcwzg9uGctND8sumNlaHGuBLl2O02VBKSzfwVlGtx0jqpR21Wv+PP7tlEX8vR4gd3qwdL3ONuALMHqAGXJmQKJuqoF50qS33Zx66LVZrJDIVJ7k8xLY3VPXZoGFg41+q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769694597; c=relaxed/simple;
	bh=Kx1nkocKHg2r0KbodzyE6L4KOQagRhJ/saQ/g0TrF+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI74daGcZcaRA1R9pHchWhhp3YZvq2sC05YP72xOnd7PIDBybAdJpxvlxitLxDPDa47J6z9EoY/rQTU9NpHNAMo2o2npzL3XaS9NaZgQ5nUjcjl7mwcaHa5rTXfUxXdrCGM1AtvWQE5iRvGaTdtCZRjQXzL0B+Lb38wuoCKZF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=MqUu8Ubv; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="MqUu8Ubv"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81e8b1bdf0cso562876b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 05:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1769694595; x=1770299395; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MVJS0XZnQdJSuFRyO9cJopaQzPSIm6FDGJq3O2WzR/w=;
        b=MqUu8UbvxitnXnJTGHY5ruvNJV8KH9cJGi0hvHQc5CJmR8TmY+QDdt3QeIw3DPrMvJ
         t4Ac1K4x1Mncr0YnE4dabFNV5Tfd6P/o2dsY397c00UyyQBESfQw0jjGSharhjhEa4oU
         mIps82+3jo8ZbtGssM/JphJrze1iOruCydgoiECd1xWQJKlyZjRNv56Lek2XBgh2jmrC
         9S+Hhc9FHEBnY7wjFgIPujlErsDg1rjFHEFzt7rVU2FbSow3Me6ZOdr5HMV7eVndN5tP
         Vm9R4zyIqvPbtOTklEZGTDcZgzHLBeL/QeWmvhRIMjVt/F+KfPTfgOdui5nMA9Ea9xYd
         PlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769694595; x=1770299395;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVJS0XZnQdJSuFRyO9cJopaQzPSIm6FDGJq3O2WzR/w=;
        b=dRWla/Vni/HmQ+Kx7AMDk1gXmrCOeDaI+HSEkN1P373W3eDNiO2vpj4KilbmFqyo6K
         +sk86oi8K5SlFjXhoiqwlMICbnQEt60AMbQ4FPbVVak4Be8o1YzrxkVBpR6eAI4nJa7J
         9FNWh3+Adrqinh3ZPpbAppPVrhvNIoTVi+xHtLBDx6c3wZdYRtGcNHqCpDbhoataj7BG
         fsQdRD1j8DpaOCVyqgHiQGEbLFv5bIRFG/1B9JaJ0nxqKkhbtrV0HPVkEok6d4sHjVtd
         rW74rzmHoKq6GK6V6+1DYKyoS75w9iwdBJHtWeSZq6J7Y52mJdubcVJ90Xs83Gm42O+7
         Uf/g==
X-Forwarded-Encrypted: i=1; AJvYcCXR5xfiAPw4ogCennbe2o+PonOVWAeEPonT0x1E71Ws5PZUDR9Y0jeXtZ1w2JUz31YgXMFhy5tpDnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz59oITMHXoQpxprLlATMsiBE3ng0f8fCCL4g9dKXL4tAuXhbcV
	ql1z1dQK//yME00kwhqndLUjTwhdcKYG3Lu+Fa2qsRJstWAyMA4+YOtfRttG+5kBgzM=
X-Gm-Gg: AZuq6aJ5mzDIidESmMCC0l8cTdZS5UbB77UtEqg5BIE+GkQUtNkBUpYtPQ8s6itbgDX
	RYTFDGYe1CDP/H0Y8omlkWZpXYVRPMxIi7rc9W6rn0yCyvLHJAkvevG/vtdPzhOAe/oVuF0fmTe
	fnZE4vJWX/FBuF+kPmD/iEIcKe82ZeE10ZhRcXCusoTpjgJGOVeEuvwLUJWTZjHoE6a6I5f69w5
	upd3zfJiUVFY66yW7rRcvCOyoQ9+nFJqnuKVNzBoMAlR/gMKIBMClyQZxupfGjVsFlIeTZc6cx/
	MsRPmS4AOOAHZ5tQfqQVzldwMocKshpgTGL4yAofAiPZJJSKVL+n+D8AOaFxjHEQDQz3r8gst31
	E/VkQOBkljLa3TtgDLMmQ5FkuMUAbEJTeG3d00GPgJ5qFxePNXtTI9TDXpzcMkNYrw34Z6xg3aK
	/ab3vP855Q0MdluHhkQw==
X-Received: by 2002:a05:6a00:2e2a:b0:800:8fdf:1a54 with SMTP id d2e1a72fcca58-82369275931mr8476106b3a.34.1769694595607;
        Thu, 29 Jan 2026 05:49:55 -0800 (PST)
Received: from sunil-laptop ([106.51.192.152])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcaadsm6072882b3a.37.2026.01.29.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 05:49:54 -0800 (PST)
Date: Thu, 29 Jan 2026 19:19:43 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, huyuye <huyuye812@163.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Robert Moore <robert.moore@intel.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, dai.hualiang@zte.com.cn,
	deng.weixian@zte.com.cn, guo.chang2@zte.com.cn,
	liu.qingtao2@zte.com.cn, wu.jiabao@zte.com.cn,
	lin.yongchun@zte.com.cn, hu.yuye@zte.com.cn,
	zhang.longxiang@zte.com.cn, zuo.jiang@zte.com.cn,
	li.kunpeng@zte.com.cn, Sunil V L <sunilvl@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [PATCH v2] ACPI: pci_root: Clear the acpi dependencies after PCI
 root bridge initialization on RISC-V
Message-ID: <aXtld38sQ9qFoNKk@sunil-laptop>
References: <CAJZ5v0iZukqD0atbdfBnmZAxUzNB6sTcJ1YUeAo5a8NRn-emEg@mail.gmail.com>
 <20260127194648.GA368841@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127194648.GA368841@bhelgaas>

On Tue, Jan 27, 2026 at 01:46:48PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 27, 2026 at 06:50:24PM +0100, Rafael J. Wysocki wrote:
> > On Tue, Jan 27, 2026 at 6:26 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jan 27, 2026 at 04:00:49PM +0100, Rafael J. Wysocki wrote:
> > > > On Mon, Jan 12, 2026 at 3:17 PM huyuye <huyuye812@163.com> wrote:
> > > > >
[...]

> > Not really.
> > 
> > acpi_dev_clear_dependencies() is related to the way Linux uses _DEP
> > which is to defer the enumeration of dependent devices until the
> > devices they depend on are ready.
> > 
> > So by calling acpi_dev_clear_dependencies() the driver basically
> > allows other drivers to bind to devices.
> 
> I assumed the dependency expressed by _DEP would be satisfied by the
> execution of some other ACPI method.  E.g., the dependency might be
> satisfied when a _REG method makes an opregion available (although the
> spec seems to suggest that's only one of the possible dependencies).
> 
> But in this case it sounds like RISC-V is using _DEP not because of
> any ACPI-related ordering requirement, but simply to enforce the OS
> enumeration order (and therefore naming).  I guess this refers to PCI
> device naming, so I suppose that dependency is on
> pci_acpi_scan_root().
> 
Right. Devices that use wired interrupts (or GSIs) depend on the APLIC
interrupt controller being probed first. ACPI uses the _DEP mechanism to
enforce this probe order. However, when multiple dependent PCI bridges
are present in the system, there is no guarantee that they will be
probed in the same order on every reboot. This patch addresses the issue
by adding _DEP relationships between the PCI bridge nodes in the
platform, ensuring that they are always probed in a deterministic
order.

> I thought udev was supposed to be the real solution for consistent
> naming.  Is this sort of a workaround to accomplish the same end?
>
Yes, Marc had suggested this as well, but it looks like it’s not easy to
use in this environment [1].

> In any case, your IS_ENABLED(CONFIG_RISCV) proposal seems fine to me.
> I think it's nice if we can avoid adding another __weak function.
> 
I agree. But I am not sure if ARM also can get into this situation with
GICv5. Adding Lorenzo.

[1] - https://lore.kernel.org/linux-riscv/20251126161540.6460-1-ni_liqiang@126.com/

Thanks,
Sunil
