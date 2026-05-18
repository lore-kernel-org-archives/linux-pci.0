Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD541377ED9
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 20:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779136453; cv=none; b=gs7ANWjNLlJRdljoKEWbrOZTMguRl5u736FmbqnpdsCW74xAO3LEMYLsg5SoveYFktN7Ary5os/OLeP0dyXU36Z6gnFmwPxRT1VCF58mnuYae8VPAxQMAXNzBn0lqj0wGqlLxNUG2HCnMMBVem3ai9HNTktrH+CR4yYc1ZklA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779136453; c=relaxed/simple;
	bh=6I+QElhAtc/8WabSKYbV0PXAFvgWpATjbvBd61/xDHI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKmKB/aJCzrpkGnYxdmqPp16XNZhQGBDhgNiDKGJgIu5r/5Oi3QmgIwaGcKO4TPIunULR7cLgtWd3Kua6Mx3CXhuc0lyLPHqbBvaO3Vo/YAu4Cml3ULoHgmh2LcToo2ppwf9ycudJa+X0URGyNitS6VDNvaW2+EAE6JCoD2N8rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drMkUY+c; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drMkUY+c"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so2513946f8f.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779136450; x=1779741250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTgYcEc55BDnl6ROBsBVO2eyQ8MbIi/0Xe4r8X6dKhw=;
        b=drMkUY+ciugqawq3ukBhLpwunBhAUQuwYrkglE29OG13pigY/pc31FwwbTyX/UZQXe
         keRKJUNZE0nRVsHt5XnQumz+hBjSdwSeURsAkBI2KFQjFT7tMtvVZbPkLtbfh5NzX39a
         xa/WHepdwHjbmnJLqiHhLIveq7BtmV4usTMl9r92d1oLK8zj0ryJcS70kPlVc4e9grtp
         sU0yfVkkEIb71vFGBsVluQJVF7qCYX+UGd11pPUAZAAVN0dtOMBawuirOSg18uqHz4yN
         +VDc3Q36ODvlFvsKV1sAWcO+fQHCTKznwNAvm7qKXeWUwk4jCZHBn6KQj0V8KD3eAdpO
         9RNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779136450; x=1779741250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sTgYcEc55BDnl6ROBsBVO2eyQ8MbIi/0Xe4r8X6dKhw=;
        b=Az2Ec4r5BfmuR5mVaYgkHDmuk9JiXICVZIU4hcnu+RbR6QYmH0HJcMbhCawaerqpsS
         Z1unlu/8y7nlxSQLSvz7u7nNZoEGz90t9jQBoP22f6qkNgWdnCv+InHBMNdl1OP+CJnI
         lRgrXveJBkWX3JELIIXlIf+UlT3SqOquPp+8E853C2N7o1ckK1mQhkGLS2RtF32J0Ryn
         v0DP25irJSAqMIfo6MiYmJpHm4nEML+Z5Tyj6dVvKaxlR2sL+AHnPutMxS7/wV8lGLI5
         L4R04XLPfRlWXZkGPZDiXdkpqxzaB+mDdqdF6ZXopWAafslZnnEDp3yxtjJk5zTAzX4l
         5l1g==
X-Forwarded-Encrypted: i=1; AFNElJ+QdCiLeXDEvWLJkb/HAfVI+ynLEKTgd+78YELS/htwwqn89k++V0KCKtynNuXyy3jKT2MdHKjngJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS//teMj1myjKnP5206vHj9xwUWtr0cJktN7+HZoIRTloAwkiL
	a+bECFvdi9XGu2vyhUMCiBV1qCfn0DDs8kbYVzhh4qj50R+ts/R94q7U
X-Gm-Gg: Acq92OElMRp3gX24aZWExI1b8lqYqCh98w1yzxabHOR7iqCrNlnY0T1PWOkHDYm5ZDd
	kDK0hlHTBp12nWKYXsOXl0XnILPppZ+HJac3MzU/n9R3U3QqPqdfRbDRuPweIVxfJqk0WoB8Ga4
	PLekk/DCWHZdeT8Lj15sNrSL+VRL3Cka4mvvlPbLsV/529fRIaOkRGu0b6mYFKgYEuoj8idQsZZ
	UOT3upU3RyKJ9a40AYkuoNit4Q+JbXlI6/mSDGUyuZxFSq1mmsrVFs9zCmWtxOAO6jCVaU2V0pC
	uPj6KzWwVyQVpoO/KtsUqH7eQ+eA63U2XPehcJp5VdGrn1uzuzKD3pCSxZooOsLisEyO/0J1V/H
	yR2/f2TvCayeIjOJizgr++LphVe7J+NScnJD9RAmJJZmRy3KcXq9+vVDGGpoDXL7HWWryIPDYFM
	kJ7tcV7rdLt5zFaazXInSWpzS+G35DIXnoGaSmpDb+/W0=
X-Received: by 2002:a05:6000:402c:b0:453:9897:76aa with SMTP id ffacd0b85a97d-45d93eccfbfmr34057576f8f.21.1779136450085;
        Mon, 18 May 2026 13:34:10 -0700 (PDT)
Received: from foxbook (bfk48.neoplus.adsl.tpnet.pl. [83.28.48.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ec3b18fsm36967631f8f.11.2026.05.18.13.34.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 18 May 2026 13:34:09 -0700 (PDT)
Date: Mon, 18 May 2026 22:34:05 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jihong Min <hurryman2212@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mario Limonciello <mario.limonciello@amd.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, linux-usb@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, "Mario Limonciello
 (AMD)" <superm1@kernel.org>, Yaroslav Isakov <yaroslav.isakov@gmail.com>
Subject: Re: [PATCH v6 1/2] usb: xhci-pci: add AMD Promontory 21 PCI glue
Message-ID: <20260518223405.06cd8fbd.michal.pecio@gmail.com>
In-Reply-To: <f05e075d-a87e-49b5-95f8-5858d21acf64@roeck-us.net>
References: <20260517130407.795157-1-hurryman2212@gmail.com>
	<20260517130407.795157-2-hurryman2212@gmail.com>
	<20260517232147.34931718.michal.pecio@gmail.com>
	<f05e075d-a87e-49b5-95f8-5858d21acf64@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 03:55:52 -0700, Guenter Roeck wrote:
> On 5/17/26 14:21, Michal Pecio wrote:
> > Instead of the X86 heuristic, would it be possible to build glue
> > code if and only if SENSORS_PROM21_XHCI is enabled?
> > 
> > This seems to work:
> > 
> >   config SENSORS_PROM21_XHCI
> >          tristate "AMD Promontory 21 xHCI temperature sensor"
> > -       depends on USB_XHCI_PCI_PROM21
> > +       depends on USB_XHCI_PCI
> > 
> >   config USB_XHCI_PCI_PROM21
> >          tristate
> > -       depends on X86
> >          depends on USB_XHCI_PCI
> > -       default USB_XHCI_PCI
> > +       default USB_XHCI_PCI if SENSORS_PROM21_XHCI != 'n'
> >          select AUXILIARY_BUS
> > 
> > I don't know if it's the best way, perhaps it would be preferable for
> > the hwmon driver to select the glue, but then I'm not sure how to force
> > glue to become 'y' when xhci-pci is 'y'.
> >   
> 
> Unless I am missing something, that would disable the entire controller
> if the hwmon device is not enabled. That seems a bit draconian to me.

I haven't tested (I don't have this chipset), but it should work like
the similar xhci-pci-renesas module, which I'm familiar with.

When the special unicorn module is disabled by Kconfig, xhci-pci no
longer rejects its devices and works with them normally, like it always
did before the unicorn module even existed.

It should be the same with xhci-pci-prom21. You don't need to enable
this module to use USB, only for the special functions. So if hwmon
is disabled then you can disable it too.

I always found this dual-driver solution (for Renesas) rather ugly and
confusing, but so far it's the least bad option tried. Hmm, maybe the
next iteration should be an aux bus interface for FW loaders...

Regards,
Michal
