Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A52874F5
	for <linux-pci@vger.kernel.org>; Mon,  9 Feb 2026 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770661009; cv=none; b=IMxGXy1ZEYt8kZqd8jImKBF8hsJdEJiI3PDrFQOp0HVAL7iuQ7ea7FR0v/qtN+bFcbB2VDPMOBgyMxafj6TX/a5e6LT4mHkBDHFrE2150lezDvDE9IPBCbPx4zSgHpAodQc8vLlRwvlWZ9wU3n2T0qslmXOCBP9pYfks2HzPXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770661009; c=relaxed/simple;
	bh=6Safa/AFdSPxR4E7qmO5/3RAlCqJFkZH663ZCt2aqqA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHiXw5VnjrZpeTApIQAisBiQBJpu+pFNdonZ0JflMghN2yFlG2Xvuw/bJ6PN1utdcDrTGoiDGyuMQIvhsDVOhQw5CJSdRXvbTJ0z90V4P4pFd8mH+nDyYSL8j5gWnGiNY9ZgiRpakJExonbSamxG1WpsR/FT2d+oz9vXu0P01i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AuKC74Tx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AuKC74Tx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43284ed32a0so3242782f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Feb 2026 10:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770661007; x=1771265807; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aBHcqVb4t+rzmfvCo3pUilF0ZcH72MfxGN0x3yxpOVs=;
        b=AuKC74TxBH8ATMNkhLFOyxsiwFHCLjddghE+hYyJKOBJBpklUuRJq5FIQ8Y219CRxR
         57GCfQJlhn7DK1xkNRz4ljqEDGkWSL7PabF5MfqT2ZkyCqlDFsrxcfF+/odEntIQe4lu
         oMH3lCyIfQXlDUo3bVzT4MSaoJxBQojW+04FDZSKTH0t4iugqVFoPv1uF71Mtg//CU51
         t+meXbQ0nOpRKfm7vaCrFyNtQa4uN37wnK68O9xNkAfqm/944r7fdouBDJBT6+hWDY4V
         NfYk948BYgzAn92+XwimhU2bpmSArtzAfvXk9iXhR98sZ12Ca1mPn1EEB9JhEGJSKpWs
         1XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770661007; x=1771265807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBHcqVb4t+rzmfvCo3pUilF0ZcH72MfxGN0x3yxpOVs=;
        b=dyvdkg17CKV1lCaiU0rH53Go0gP/83KRa3v8PmckYLISUnnWPJ2eOEdPhkFEP6sHKu
         LvArUcqsGagJe/jH5mH39+fDpUC7uK1XqVNrYl/N66y+11ki0Mejvf8wRg/T1+AB4eA9
         N3d/oPOJOV4hmszMdcdCt+MvZKZs63QOJHIoBIM3x7tRHhYI9Tkbw9wSrgXzwGMiMZsO
         xHHWjyDUDwdN/d+TOhYyIBgLH1N2Qn55tZ8YsRLGapFVzAzZvmfTNhG8WOPyUriViGap
         91xelKlrMlCfrhF2OAcXBhSrLpTED3rKlBbEt+j8k2LQvVzR98ZHjZPCH7qG/c3Q/eZJ
         FpkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7hRbsOoMvizRY7jKTHEzSEZbbEwryY5q278wzFpAv02T/l9d8zaRq188K2d1emSWP1vaFqbDrg7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZrgF6QCkeG5YkmUrDPmx339lGlkpWMc9PqV7kI5bf/EfyJ1T
	fRiH7Rj444depZNU0bNVc3Rst7iadlRlAYkQbKNaRtDTRtVIdOIT1DQ6VSq2Kz4dwEQ=
X-Gm-Gg: AZuq6aLNb10gtID0WE+u90W66NvopRq64sNVuHDKRKScxj/IB9RNA6zt+k0yfr9zo9U
	yU9MG2Xg8IRB+Geu7bfAlcryrwZXs2l8/TeHEKUT9cxDYVXxrQqg+eg+63Oe8EudnN4to2kvIXj
	jXsr6G0fAiufz9C9Ve/8VJkGrAKyohz9kTjekLajJkva/1W+upiMJNV0HxvplHqvaZGIgF9aKp/
	2yesPk4gHDYPwWbxrbLSnFfZLVU8V2yQUgyyIu9rdGgAewSCZxVRu0HEUfgThE6fymyycJwJAan
	vYie4liD1OcOydexd64oDExiBcD9/OmjFoc9jQiNdlGN9eALCRu4W09a6Udz+A2lZz1GY8nQ+5n
	sIhG4S4YBPxEwXMNDk67pG52V2HsBGlM7FBlQ+/KRFxlRX+jmR8pfpyu9hreJi0ueWfE4pEHnna
	4EBtADyYyDHNKBOCx5iis7UUTa4T1gZU1v8VFmbw==
X-Received: by 2002:a05:6000:1ace:b0:435:a815:dd8d with SMTP id ffacd0b85a97d-436293b244fmr16995444f8f.55.1770661007108;
        Mon, 09 Feb 2026 10:16:47 -0800 (PST)
Received: from localhost (93-41-3-120.ip79.fastwebnet.it. [93.41.3.120])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43629745f7asm25073238f8f.33.2026.02.09.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 10:16:46 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Mon, 9 Feb 2026 19:19:34 +0100
To: Rob Herring <robh@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mbrugger@suse.com,
	guillaume.gardet@arm.com, tiwai@suse.com,
	Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH v2] PCI: of: Downgrade error message on missing of_root
 node
Message-ID: <aYolNrRSU_IlgAFn@apocalypse>
References: <20251106182708.03cfb6c6@bootlin.com>
 <20251106175016.GA1960490@bhelgaas>
 <aQ28s57R0YfrqwdG@apocalypse>
 <20251107125828.18a034de@bootlin.com>
 <CAL_JsqJ_gCu_A2YqX4r2UMWssJ=4FprsM_Os3Zw=V8yCTGubdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJ_gCu_A2YqX4r2UMWssJ=4FprsM_Os3Zw=V8yCTGubdA@mail.gmail.com>

Hi,

On 07:58 Fri 05 Dec     , Rob Herring wrote:
> On Fri, Nov 7, 2025 at 5:58 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > Hi Andrea, Bjorn,
> >
> > On Fri, 7 Nov 2025 10:32:35 +0100
> > Andrea della Porta <andrea.porta@suse.com> wrote:
> >
> > > Hi Bjorn,
> > >
> > > On 11:50 Thu 06 Nov     , Bjorn Helgaas wrote:
> > > > On Thu, Nov 06, 2025 at 06:27:08PM +0100, Herve Codina wrote:
> > > > > On Thu, 6 Nov 2025 16:21:47 +0100
> > > > > Andrea della Porta <andrea.porta@suse.com> wrote:
> > > > > > On 13:18 Thu 06 Nov     , Herve Codina wrote:
> > > > > > > On Thu, 6 Nov 2025 12:04:07 +0100
> > > > > > > Andrea della Porta <andrea.porta@suse.com> wrote:
> > > > > > > > On 18:23 Wed 05 Nov     , Bjorn Helgaas wrote:
> > > > > > > > > On Wed, Nov 05, 2025 at 07:33:40PM +0100, Andrea della Porta wrote:
> > > > Patch at https://lore.kernel.org/r/955bc7a9b78678fad4b705c428e8b45aeb0cbf3c.1762367117.git.andrea.porta@suse.com,
> > > > added back for reference:
> > > >
> > > >   diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> > > >   index 3579265f1198..872c36b195e3 100644
> > > >   --- a/drivers/pci/of.c
> > > >   +++ b/drivers/pci/of.c
> > > >   @@ -775,7 +775,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
> > > >
> > > >       /* Check if there is a DT root node to attach the created node */
> > > >       if (!of_root) {
> > > >   -               pr_err("of_root node is NULL, cannot create PCI host bridge node\n");
> > > >   +               pr_info("Missing DeviceTree, cannot create PCI host bridge node\n");
> > > >               return;
> > > >       }
> > > >
> > > > > > > > > > When CONFIG_PCI_DYNAMIC_OF_NODES is enabled, an error
> > > > > > > > > > message is generated if no 'of_root' node is defined.
> > > > > > > > > >
> > > > > > > > > > On DT-based systems, this cannot happen as a root DT node
> > > > > > > > > > is always present. On ACPI-based systems, this is not a
> > > > > > > > > > true error because a DT is not used.
> > > > > > > > > >
> > > > > > > > > > Downgrade the pr_err() to pr_info() and reword the message
> > > > > > > > > > text to be less context specific.
> > > > > > > > >
> > > > > > > > > of_pci_make_host_bridge_node() is called in the very generic
> > > > > > > > > pci_register_host_bridge() path.  Does that mean every boot
> > > > > > > > > of a kernel with CONFIG_PCI_DYNAMIC_OF_NODES on a non-DT
> > > > > > > > > system will see this message?
> > > > > > > >
> > > > > > > > This is the case, indeed. That's why downgrading to info seems
> > > > > > > > sensible.
> > > > > > > >
> > > > > > > > > This message seems like something that will generate user
> > > > > > > > > questions.  Or is this really an error, and we were supposed
> > > > > > > > > to have created of_root somewhere but it failed?  If so, I
> > > > > > > > > would expect a message where the of_root creation failed.
> > > >
> > > > I think we should just remove the message completely.  I don't want
> > > > users to enable CONFIG_PCI_DYNAMIC_OF_NODES out of curiosity or
> > > > willingness to test, and then ask about this message.
> 
> No, please keep it. Anyone that enables CONFIG_PCI_DYNAMIC_OF_NODES
> should know what they are doing. I was thinking it should be hidden
> behind EXPERT perhaps.

Ok, so it seems that this message is there to stay, can we just turn
it to a warning to relieve pressure?

Thanks,
Andrea

> 
> > >
> > > Agreed. This would be the easy solution, the other being creating the
> > > empty DT so that the message will never be printed. But this require some
> > > careful thought. The latter solution will be needed if we'll ever want to
> > > make drivers like RP1 or lan96xx (which uses the runtime overlay) to work.
> > >
> > > >
> > > > "You can avoid the message by also enabling CONFIG_OF_EARLY_FLATTREE"
> > > > is not a very satisfactory answer.
> > >
> > > Unfortunately this would work on x86, but not on arm. And who knows on
> > > other platforms.
> > >
> > > >
> > > > A message at the point of *needing* this, i.e., when loading an
> > > > overlay fails for lack of this dynamic DT, is fine.
> > >
> > > It seems fine to me.
> > >
> >
> > Ok, even if I would prefer having an empty (or not) of_node available on all
> > platforms, what is proposed makes sense especially in regards to potential
> > users questions.
> 
> Having a DT always available was the original intent, but the arm64
> maintainers resisted so that's a fight for another day when someone
> really wants to use this on an ACPI system. Now riscv has done the
> same thing unfortunately.
> 
> Rob
