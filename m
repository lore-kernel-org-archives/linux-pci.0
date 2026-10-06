Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8039843FD1F
	for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2026 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791298874; cv=pass; b=F6nDP92U0gmFuES0E0yL2ElKp0e2tNFxp8RqmpCFoNwjLhtdjvmhOldCgIF70gzLWZ3lIi1i5EbDLEamf8KN4AFPKeB/jpeXwPSNO22tMgk5su3KvbC4mFJ9D8ZHVnPQ5FI/KUROw98JnaM+SRJazQdVU7hncQkydnq8lILg3qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791298874; c=relaxed/simple;
	bh=z0NbjY3hb65QgHF3JTWDHVs8sB4ltcgs7siabYrSJxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQSgnzfdBHK9jDJ19kxjt9ZZw8VdTDR2+dof5rZ+yugviPPCZHN9AaQ2Ni8qmMKIKziI5ChThGGSNWFBB62AFPjl1ZE1SrXUbluRyIuIN/Kg5V/8BWUclb/qO2qGOyFqL7J0Gc3AltVlPDhU6/jt2SCrdzcLR+TheBltdkSBwbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnYnsB00; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnYnsB00"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so103516866b.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2026 08:01:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791298870; cv=none;
        d=google.com; s=arc-20260327;
        b=XAipL8t6fYNQC0USOF9vZJb4row0t74073IRBbr4jTY0puOCRa63JOAga+fwruFAAf
         5x14Ll/i25cjiy2jFMXopByqqCX6Edop/sD6ig4mpjodCVhh5P/D0qXLFBTLJc2GLOhf
         G1+XB5aHavw0mI5skjm2Apco/WzdFTHl/7dHsQJQdXUfMzLCMp0QE2jUI7DPCXW1F/5g
         m5LoPAPS2A7RtFzR3QDgkr8r48kGKE94uKV4ZqQE8X52rPGGV6ea8j/9T5JvzQDcn6GJ
         M9ajLP3e04AoaMsf1mw9JBT7XKt8EPx2j0OOEgKJOjIhvXP8ThZIlnPEYSspAZzaxvwz
         gCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=poE/AoMSO13XM0pW8fLOnNeMoWk6Qs7dHNHQLFRI0xs=;
        fh=rdt33enCtsXRN9J5IIxDi44UV+OO0gXTCsH1xyhBK/k=;
        b=eBiuygIHT0rMcNz2rpbj/SFNB67AGonRrgFHNWXdecfR9HubGsve+crA94oaFv3tYg
         ToQKEVwI1X3au+rbXRTelz9Ou/2TC7Z1J2lH/KkZASH650LvE1MFKAdwYxX62mdSdKHD
         mD0ubp+G/DrxfI781CH6bgfTrz3cIFxfcr2PT0jp4KIAxyzaAboH+pZZADd8CG4MPtH7
         FbEAfVkISJX9NdZWtEfrQavqz5PIhUl4tqTzbC1bbCuxK7REvg+YdQSBli4HodFHgg9r
         phAtn/eAkY9PY//PBWTrmMNwfkiQgWt7iDOzXUyxibPbiJ6/6esh8hu7sWOzLB2FJo7/
         2B0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791298870; x=1791903670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=poE/AoMSO13XM0pW8fLOnNeMoWk6Qs7dHNHQLFRI0xs=;
        b=pnYnsB00t5PvZf4O9XAH7SFW94Dl6HdGdOKBcc2cXh27IcoLCBP85HtQqS9Mj9UOFC
         uhZI2BRz0evRDbAe2aMkXdo1XB/590nFlP6khhTfI3ZuSk6EefAOsocvKxsnuKDKEUGW
         DT9xdNYRQWBxfxrCH8POzIk6roMQV83HOreYAOVfaPEM91pXWYF/wu4TxC31W+JmUONi
         bY5Pb5P8BltHsl/VH/ndf0Cw14pk48z2WvcLPt44kw0QV9U6Cya3WZVAKYelWCDhqQlw
         QfbCCE07isyYWWbOX25v2PPauVG5Uidm6cNhZGpWCTy85pWoxZrELB96ZOb/7Ls5ZozR
         JK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791298870; x=1791903670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poE/AoMSO13XM0pW8fLOnNeMoWk6Qs7dHNHQLFRI0xs=;
        b=p2ywllKZbthOWzSguKI0ecGZ9R7+dlK00VzGVh5jFkLBSP+qn8yDYYEYqe6fo+TrmU
         cegYP31/BP8L371W714v3pnnYj+6S+NMdGpD/DiXan+zejNjXWu64aT0j1Soedswf1Ho
         AjshCTCGtNhyezJ+NZubd8Uh2dCrmyJ8nLwaWms0i8bnl3o9F/FtYSBwsSk74uOO4bEz
         5juaw28TeqjfRSOA5FlkCdTxWNUkBJiGKL1fdk9HCyTo7sGR913RJpNoPdiRsTDk3MPu
         btSB+l8NxhtE9/TLoAgTff56VBaXS7YWvC0Z8LRrB4U4ABNnISW68Tl9IWWZjJfJYTMC
         XicA==
X-Forwarded-Encrypted: i=1; AKwUvBxDrRAMFb9vxEwhOoZz7p11wq7crIM6gJ04rHjuEePNHbDecupBssZfpeHUmv6RQp6jSM+o9gSprEo=@vger.kernel.org
X-Gm-Message-State: AFuF++l3hwMC9Lb7j0fUODOa1U78m0/h8sMMNOewvANaIBoRHGI/ZJqO
	Z6AQgUYHn2UML/fuLz14JYvy7v5EWJGVxHBtVwsi9YzyQXWFlgnbdtqRiq0/y8pnNPY8oGL6Ou2
	npb8zouL3jq46q4GFcDol8nQ/DG1RboU=
X-Gm-Gg: AYBFou0OtsYgZbXE/vLBW0d5cjRLvF+1BNwVtEjp0jNqQUhMn+oAJ/R75HZWvmzfPhM
	WhKVzi+vwFodiAf4vcF9kQfHBlRWILAMyhbm7rLW8NKsvifCkVUKrxBBfXxvq0wG2HQd3QK1tL3
	x4vsRDl4kNU55na2BxnbPprfcWW+6N3ATtqPcijzSamjUYj8UMVW8MRvoArdDnC6hPhwLVz2yRY
	CX+p+IpAwcCnW2nP0ItL1Tva/HVY1U3hoVYX+NVk1GkGq1NKkfz3hUoh/DCBjmOwH64Xak9CXuo
	mAD9JHuEKnjxmYwzVwc6ayxx4Hx8/Z6oJdPdLyUHWtqUvTaokUqZebXL8Y5hzfGoIaB/hnzUAeQ
	VV5HD/zo7WFU9VeSl+BQmT2TWZRJ3a3/yi41zNf1ohUMVZrNFt5K+MsByE7bkPd3N51lSL/6WqO
	ooLbmfCF7omocxOfTxYY0A
X-Received: by 2002:a17:907:9618:b0:c2e:49b4:ab8c with SMTP id
 a640c23a62f3a-c3169f86340mr164162466b.14.1791298869485; Tue, 06 Oct 2026
 08:01:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZrw2HcaOh3DHTJtxU5dXrb3Vg19scr6+qR-xe_+R7rME35_Q@mail.gmail.com>
 <20261005231914.GA639967@bhelgaas> <CABZrw2F=pOOq7+puKohtYMihYqWCevCFc7rkAOETW4T5Nf4n8Q@mail.gmail.com>
 <asRjch1fMBslk07D@wunner.de> <2a7a97cc-7ad0-4e6f-845a-dd841d36079b@linux.dev> <asTDCW28kKBfKAVs@wunner.de>
In-Reply-To: <asTDCW28kKBfKAVs@wunner.de>
From: "Perlow, Jason" <jperlow@gmail.com>
Date: Tue, 6 Oct 2026 11:00:58 -0400
X-Gm-Features: AclHuK__dVMPtlbG_nW0AT2uQ9jcKaXMGxE8ey6R9y5x6f-QHJqrNDrofO4pLOI
Message-ID: <CABZrw2Ht3f8nJU7bJezSMuVWfrejV0HzqzRPA=ibQYPc9dGKoA@mail.gmail.com>
Subject: Re: [REGRESSION] PCI/AER: MacBookPro16,1 powers off ~20 s after boot
To: Lukas Wunner <lukas@wunner.de>
Cc: Aditya Garg <aditya.garg@linux.dev>, Bjorn Helgaas <helgaas@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lukas,

On Tue, Oct 6, 2026, Lukas Wunner wrote:
> Advisory Non-Fatal Errors aren't handled through the Uncorrectable
> Error code path. The kernel just reports and clears the errors.

Thanks, that corrects my guess. My first mail and my follow-up
("a second, separate way for eddba19b8b5f to hurt a platform")
assumed the uncorrectable recovery path. Please disregard that
reasoning. What my tests show is only this: with the bit unmasked on
04:00.2 (106b:1802) the machine powers off at 14 to 24 s, and with it
masked there only, it stays up (120 s). I do not know which action
causes it.

> A quirk does sound like the only possible solution. However I'd
> really like to see lspci and dmesg output with the bit unmasked
> shortly before poweroff to get a full understanding.

Understood. I am preparing a capture that survives the power cut:

 - kernel messages streamed over the network, as before;
 - a loop on a second machine over ssh that reads, every 200 ms or
   so, the Correctable Error Status and Mask and the Uncorrectable
   Error Status of 04:00.2 (and of the root port 00:1b.0) with
   setpci, and logs them until the connection drops;
 - lspci -vvv of the whole tree taken right before the bit is
   unmasked.

The ssh session was still answering at about 16 s in my earlier
runs, so I expect to get several samples before the cut.

I would also like to split two possible causes with the diagnostic
kernel, if you agree they are worth separating:

 1. the config write that clears the mask bit on that function;
 2. the report-and-clear that follows when an ERR_COR message
    arrives (the status write on that function).

Case 1 can be tested by unmasking but never touching the status
register on 04:00.2, case 2 by leaving it masked and clearing the
status once at boot. Tell me if you would rather have a different
split.

Aditya: thank you for the Windows listing. It shows 106b:1802 as a
"System Device" there, which tells us it is enumerated but not
whether Windows touches the mask.

One small point, Lukas, in case it matters for the Windows check:
the Advisory Non-Fatal Error mask bit (bit 13) is in the
Correctable Error Mask register (offset 0x14 in the AER capability),
not the Uncorrectable Error Mask register. The status bit is in
Correctable Error Status (offset 0x10).

On the form of the quirk: I will go with whichever you prefer, a
flag in the PCI core that pci_aer_init() honors, or a
device-specific DECLARE_PCI_FIXUP_EARLY for 106b:1802 only. The AMD
switch port 01:00.0 is not involved in my tests, so I would keep it
out. I will not send a patch before the capture above.

Thanks,
Jason


On Tue, Oct 6, 2026 at 5:44=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrote=
:
>
> On Tue, Oct 06, 2026 at 02:01:52PM +0530, Aditya Garg wrote:
> > On 06-10-2026 08:26 am, Lukas Wunner wrote:
> > > On Mon, Oct 05, 2026 at 08:17:12PM -0400, Perlow, Jason wrote:
> > > >   masked only on 04:00.2 (Apple T2 Secure Enclave, 106b:1802):
> > > >       stays up (120 s)
> > > [...]
> > > > So here the trigger is unmasking Advisory Non-Fatal Errors on that
> > > > one function.
> > >
> > > That's quite unexpected.  Maybe there's a bug in the PCIe IP which
> > > Apple used for the T2 Secure Enclave device (which I believe is a
> > > fully-fledged arm64 CPU with a PCIe port in Endpoint mode).
> [...]
> > > macOS likely never unmasks the bit and so they never saw this during
> > > validation testing.  Is the T2 device visible on Windows?  If it is,
> > > it seems Windows doesn't support and unmask Advisory Non-Fatal Errors
> > > either.
> >
> > T2 device is visible on Windows as well as "System Device"
>
> It looks like lspci is also available as a Windows binary:
>
> https://github.com/pciutils/pciutils/releases/tag/v3.15.0
> https://eternallybored.org/misc/pciutils/
>
> Could you double-check whether it unmasks Advisory Non-Fatal Errors
> in the Uncorrectable Error Mask Register, on the T2 or any other device?
>
> Thanks!
>
> Lukas



--=20
Jason Perlow | Argonaut Media Communications

Voice/Text  (954) 242-3484 | jperlow@gmail.com | Blog: techbroiler.net
Read my Tech and Food Industry articles: https://linktr.ee/jperlow
Bluesky: https://bsky.app/profile/jperlow.bsky.social

Need to schedule a meeting with me? https://bit.ly/3y8P3Gp
