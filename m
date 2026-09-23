Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE93392831
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 21:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200267; cv=none; b=U4fdFxFQVEKrL0Ri1oUTbnMlrUKtjl7Qj+BRTDCDFDhGN/ezZhlY49WXj7GysO8zEV4cNZ3xRyYmwyjHumsNXXeXP3Nh91A16uwDHzG5Js5B9FJJHiuNQoiJMB1M/EuRaAoYXft9mebl22ySau5MWCGw4Z+hA4+hYzERWg83HnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200267; c=relaxed/simple;
	bh=IgxTQuGeICrd5MzQGmpTL/c1gTtW/uQz3Qz7w3LwLaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7ceE5FIGPl6IHTNuufQ6YpM9llkU6KzSC16NISFmW7ecEvBgbjVUkSv/LGDBsNk8Dh8rwqCkEwOr7kelImcpnVi0UomTlmAKKloTTUDA8MPp3dgociZLMQDnIMnOY2t2jltqNbk7EAH1g2GVIclNPpO0LQ8t4VBbsPsb6SdATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijlbFhsE; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijlbFhsE"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e620fa473so8347205e9.1
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 14:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200264; x=1790805064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bA3OJe4KXebO5yMPraruGl/foJ6oDyZS8+2CGZOOFhE=;
        b=ijlbFhsE18WWMeAysPZFcwyAMX8Uua7zvLvN8PYncgtCGiuKHVuJIJJqBtgAV6VddO
         Cbn9/Zd2iulKjpcTMshUp97Elz4RW0xEQujxH4UWVkBP9DKVS1DpODynHhZ6HRsMQJtk
         QL14LKxlPL4CEzEpfEfT11cgmyulHSwyX9/HrWHq9gFpm9Q9UhcOC4l5tyO4SL5gnzhD
         ub/t/zWhNuNNAELDlF3SeHW8W23oD8w5DeZVg/Tmle82aRsXPX9sIf49OekBQjCoUJBD
         2isTp9ImGFOVu1SNu/w9te98ZW3nW7gptqR7xno4XLuvr5IweraNtT7sc/AYMvQe/9dP
         1/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200264; x=1790805064;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bA3OJe4KXebO5yMPraruGl/foJ6oDyZS8+2CGZOOFhE=;
        b=TK6VhfWjjDF4HSvoUjmiE/RnkwN9IR7Ws5HQGk9Xk6XCer91uo14EagEOXQb11rI1V
         BmdlliLpZKhAHD2ogu6lGI71T+MTLFMhDOapGnlHurnveS3OKvzQ9+q1CN5IhiCm6yRX
         CrE8w4nNTpVPcezYzBnAxc+Cv8EuaxiKZ91JAzy0Y1KNiX+H3yhYdGTDkflmzcwrpCBd
         WzDgQ0xl7hGYctMm3tUe2p/3231h1HOhDkGa/CiV4p6ZKpJp8cbY3E7jTQLD3LI+7+H8
         GcO48ue2WrF915wuJ84tFeylVVcXJd0b7BhpE8mEfQo6wshcbKAW7tpiOu7sf2ZW5iNL
         bIHg==
X-Forwarded-Encrypted: i=1; AKwUvBy9UbMKK/0yPTcK9iimq07rGud+quPOgGj+xur2yQXr6YuAcM7Ewmu6pMPMnGYnDWGgXtVxJpGGaYA=@vger.kernel.org
X-Gm-Message-State: AFuF++m7ALY501lS8a2wG4q4dqRLhW1blOKEh9uca6zZp0PEfGy74y2k
	78dCHdxAPGglxuj1KQ4+YXnnWPE/DsBqWYtQesNt4xw4+/wWYlaoqrV2
X-Gm-Gg: AYBFou20wzrzq96BjCpg6+y+8sbp+SZb4aPxUD1iwROalR4d6W5PGI51TPDL6gthWx/
	pFihSqi32UhrKodDJx2JVQIf58rI9+JwIReNJ0HmkmDR5GcC8+o+OtdjQUvhtr1UqIAM0+ec6A7
	TJMGB+121XSgErpjrWAiRWk5g8GsL61G4J+xQaf4stDOe8bZQB09yN60ViIs6as+hKvCS7vkNUU
	hZcxzTT/gEZKbRZjKvtiavAOh1Bai96mzgmXys/ehwQYkJGfycjQrCIGDeguk9b49+8t+HPuaiR
	S1MBCZFF2+Ob2aMlCnLSgBc9Pvpd6cWw5aMjW/XU+w42XUnGWN6bXjePFo4CcjyyrEB2XUHHhIg
	K6MqLIqXEa21jH/2yNGi0G24rxGOqUawinXu5LOIwqVdWXqn5miIhHsN26i4l/pMlTTvKGBM6/t
	/rOq+lnNtGXWpw5YNyGMDJC+3A9bsF+NH/DyInM1NJlE9Cg9EGBmmYblM+Qw31Sa6CMkMbPN+A7
	ASvJDQ68Soe4pH+Qo0y/Q7k/VaJKcmN/KplcdphkJJM8w==
X-Received: by 2002:a05:600c:1992:b0:49d:286:83d5 with SMTP id 5b1f17b1804b1-49fe66d5537mr7659645e9.13.1790200264413;
        Wed, 23 Sep 2026 14:51:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c446e1sm72175855e9.2.2026.09.23.14.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:51:04 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:50:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Deepanshu Kartikey <kartikey406@gmail.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
Subject: Re: [PATCH] PCI: sysfs: Reject unaligned resource I/O port accesses
Message-ID: <20260923225059.5c8cf0d7@pumpkin>
In-Reply-To: <20260923205518.GA1941939@bhelgaas>
References: <CADhLXY7008e4JA35T2wE8TnJnR_r82RCpfSd=aLBmDh5xAQ02A@mail.gmail.com>
	<20260923205518.GA1941939@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 23 Sep 2026 15:55:18 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Sep 23, 2026 at 09:05:15AM +0530, Deepanshu Kartikey wrote:
> > On Sun, Aug 9, 2026 at 10:29=E2=80=AFAM Deepanshu Kartikey
> > <kartikey406@gmail.com> wrote: =20
> > >
> > > pci_resource_io() validates that off+count stays within the BAR's
> > > range but never checks that the resulting port is aligned to the
> > > access size. A pwrite64()/pread64() on a resourceN file with an odd
> > > offset and count=3D2 or count=3D4 reaches outw()/outl() with a misali=
gned
> > > address. On arm64 this becomes a store/load to a Device-memory
> > > mapping (PCI_IOBASE + port), which architecturally requires natural
> > > alignment, causing an alignment fault and kernel oops.
> > >
> > > Reject misaligned accesses before they reach the low-level accessor.
> > >
> > > Reported-by: syzbot+7134530b25073b4ef373@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D7134530b25073b4ef373
> > > Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> > > ---
> > >  drivers/pci/pci-sysfs.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 5ec0b245a69b..72f0404a34e9 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -1175,6 +1175,9 @@ static ssize_t pci_resource_io(struct file *fil=
p, struct kobject *kobj,
> > >         if (port + count - 1 > pci_resource_end(pdev, bar))

I think that test can ignore count.

> > >                 return -EINVAL;
> > >
> > > +       if (!IS_ALIGNED(port, count))
> > > +               return -EINVAL;
> > > +
> > >         switch (count) {
> > >         case 1:
> > >                 if (write)
> > > --
> > > 2.43.0
> > > =20
> > Please let me know the status of this patch. =20
>=20
> What do you think of the sashiko comments:
> https://lore.kernel.org/all/20260809051652.36BA31F000E9@smtp.kernel.org?
>=20

You could just add 'if (port & 1) return -EINVAL;' to the 'case 2:' branch,
and a similar '& 3' to the 'case 4:' one.

Did it miss that loff_t is (probably) 64bit on 32bit?
Or do large offsets get detected earlier?

David
