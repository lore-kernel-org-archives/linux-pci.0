Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8A241C8C
	for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778242; cv=pass; b=MR/JUGw5GeyEs3GwsUN9oIjvERAz0EWwODPiVcgc7wDPjzuY2VssC24H9VdSKIbal4NXisEQhFIdrxd31zkDhfbmsBAg5g1NmK+iI/sTEWM8ZN2Ouv4UovoLsHb/Pe1+bh7/LuhLIIXx6kpj8F4nCWtIWjWdj6i7VBjwLCZeV+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778242; c=relaxed/simple;
	bh=FFUNLVgGj6TBwQDXczffhQbCSgIoRnXbz8CETIMk0U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SagwsXAsd7sKTCP++olAJazFlQVk2F2azCC4I0aFipqaWKfwhKYotZXTxEwOmrUJ8J7HeUQlLkJKmsCLcKD6rJ77z3h1Vf3dMA1wwHBYa7zPsixdLn7eCpmPrreiVh9GQOi716J4XeOFFmRzvo/ama2N5kXKt+sVI2hjlBm77B0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fpeYJxEd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bmyj6oCq; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpeYJxEd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bmyj6oCq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776778240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFUNLVgGj6TBwQDXczffhQbCSgIoRnXbz8CETIMk0U0=;
	b=fpeYJxEdH9NpwWDbUF87zD0f1MupRdmHo/djHi1xTqTFQ/PzRbjYWn8kNMets3EDRWD50o
	EpQGUGHFnz+B9TxhgJsytc+BWvvyLYQuhB1L5fuE8aGCpFBBBdhy+SYWMXab5tfbMFTg6b
	GxVTnx/cAh9r/y4Jbv07yZWy2zWhKW4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-ACdU6JkfO8uB0Op1L05YbA-1; Tue, 21 Apr 2026 09:30:36 -0400
X-MC-Unique: ACdU6JkfO8uB0Op1L05YbA-1
X-Mimecast-MFC-AGG-ID: ACdU6JkfO8uB0Op1L05YbA_1776778235
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-38a247e261dso38721121fa.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Apr 2026 06:30:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776778235; cv=none;
        d=google.com; s=arc-20240605;
        b=SWP/qrRlm50Al9ze5tRm0pLceiu3C3KWFOgN5xduuXbAFD8OoMhNcXyJaocmQzKPom
         rpw3UdaEymCaBYl5GcGbkhGUxWGtiQiCCN/yY8otzyHACgVZo28f5JsbCie2vODte8Ti
         aUt7wCEAnHO2f9HMZFtIWa3iYprlHMeJXeDO95ezv2HWFuYoV846nU9R+G4l1cvOo+Pp
         c1GfZZ0pYC/KG4JjKoT8WumrsNJCf84onZrXVXtUNNv34aT1YBUMkMybRxfEDCt9zD2g
         o3jehtXfXRoN4nBfPHWVqXCwQShH2ScUItyIWZTDq6tq3o83yxEDGNzxzuLQxKxIjecW
         PP8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FFUNLVgGj6TBwQDXczffhQbCSgIoRnXbz8CETIMk0U0=;
        fh=Y3sZcX0clk8svb7aq+iRdl3WHsPdi5AzDovx8UvvLdk=;
        b=OPhQBt6geom0sXNUIGN4hTXjzjk5XswJtyrsoVEaugFkgBw6lDc41Bf+1rWn0a/tfj
         OqxTLgSy7QvrbFvwSLpkfmpFt76gd3HKqGxsdUlKwekdvf1ksfJKI+lH8WnH67fjku4N
         KEHO0XG1ZsYqhuL0yqReSrD56wjMtXe7ojxl65uQKCuwpJOVZU/5Zn0coT0MLzfAfbA0
         //JSM7GwSyMWDH5B9PT40VpoEF3kczl/NlOJybbYfMNmvqeI5KbQaNZRx/i+NUBCLMt5
         o2tGYLcJAoG3XCHWyu2vbbBu2qOuUYfX0a65o30VoQSOtscqhIA9oepz7cfnUYrizDS/
         Eqzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776778235; x=1777383035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFUNLVgGj6TBwQDXczffhQbCSgIoRnXbz8CETIMk0U0=;
        b=Bmyj6oCqW7YhECm3oxNrO3KIRTjLt0SGJo7PxX0vLOEOB+QSfnFjYaCVafSC6nr1XG
         kj0fkywg0zcgU0MAeAv0hMedinu6uh+fK5Gtu+K5uqLYwze6v6W/WlqAjZ50oALtUn5B
         Nnh1V6ypD3vTFuuZejO1u1ZhhwAlT+6ww3s0tU3YntkjRuyId1kELW1qDlCxrP64u1Ih
         oh9+GT3/GIfiWD8tBBzwMHlwQaWNHNEbqlSeOlJANGoKzo0CHFwUIMe3UyMIeJZwZGAg
         JU/klh9ZRkRl6Ap6HaXSigvUNsAYFbrVhXjtqTEDIuLDZdeEnZa/jSZE5uBUTgwexjg4
         MR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776778235; x=1777383035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FFUNLVgGj6TBwQDXczffhQbCSgIoRnXbz8CETIMk0U0=;
        b=i3mEqJNuDcGSPkxR8IVA9iLSajqVkpdISgVlSc5lTTWL7EqqOjj6soZSzYMko+ky56
         eh4nszJQRbfpTIV5vKTcaDp2Lxussk7r6urBSrfErZ8wzienoUsjwV/c3YjZvFzqkBgh
         1mDnyZqbNjhPCUHGiw6keONrhLIoeYj7M23gL+hIr7n+0BoKBm8sCfANUW0+O+YGTIZl
         PZbqePquEldMr7wH3wb1b++XuY8opr7fzrOCTBJ66oM1JfmT5PjOUYB0jJafJc4YaPVZ
         D3nbMjYSkYgOHVG6dlWkdI0wNpKnID91zjqMVc4nPIuBWFpjIFDa422EYKusj5+LiuUO
         CSmA==
X-Forwarded-Encrypted: i=1; AFNElJ+CO3RWzMV4F6hyjW5AlSeHzYLahcQM4uOr/utU8ILGlKE/jvBg7QjReLfBRuXzDpZlfJuj/ATGPRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEwipqAlDqkoqpSPCbyFkDNZYvii8PStrBUQ7LhOUavAvkGHex
	C2EXBVTVNiuzkb52CmYUhF1TQP7QzeC7OrVVmJfht2Z/f3eflEVK46eR0SpUJOkE9KvQfOox2Q0
	mvCmSn5kWapuIsZc+LlcXKc03mXnfydZMmDZtYaEEUcoqAuhab99Uk2lPfIKDuu0mKJHG6GLPta
	Bwyi1U27OKzcNY2bW+HtyWLYNpy8f5BPBwHLnj
X-Gm-Gg: AeBDietwtcNCPQAeSuyRRFpi5PZb7qDGCEKz443JhLFAE0F/xns2KL+s1SttpY0YjuU
	pguyRovb2tn9KXN/am1PwGteGDxnDw4NNmMS5aZ5LuRlE6H5Qz0gc7Xr08ZH5c+uDGwoJSL4/6t
	AL5yuyevieI+YPFLNFvNeR//3OIBLcGZ/fXVzAfQaEwswi1T/IR8OiLFRswil1sCq4icTCbhNT/
	IdezvmQ7YlKBL8=
X-Received: by 2002:a05:651c:2120:b0:38e:a8ef:b61 with SMTP id 38308e7fff4ca-38ec7b479b6mr54497121fa.29.1776778235033;
        Tue, 21 Apr 2026 06:30:35 -0700 (PDT)
X-Received: by 2002:a05:651c:2120:b0:38e:a8ef:b61 with SMTP id
 38308e7fff4ca-38ec7b479b6mr54496791fa.29.1776778234483; Tue, 21 Apr 2026
 06:30:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420152608.6244-1-djeffery@redhat.com> <ff05ee4a-1cd8-4750-bbd2-8a8cbab59390@oracle.com>
In-Reply-To: <ff05ee4a-1cd8-4750-bbd2-8a8cbab59390@oracle.com>
From: David Jeffery <djeffery@redhat.com>
Date: Tue, 21 Apr 2026 09:30:21 -0400
X-Gm-Features: AQROBzBtok6Yzg4ok696ORQ140C5T6p4P5qZncZ6-KrGBII8XAtSjGeJb6YcdEY
Message-ID: <CA+-xHTGSbbBYOLYgcD4_964dtuh0NzrnuBS5FT=+5+dPdV055A@mail.gmail.com>
Subject: Re: [PATCH v14 0/5] shut down devices asynchronously
To: John Garry <john.g.garry@oracle.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <tatashin@google.com>, =?UTF-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>, 
	Jordan Richards <jordanrichards@google.com>, Ewan Milne <emilne@redhat.com>, 
	John Meneghini <jmeneghi@redhat.com>, "Lombardi, Maurizio" <mlombard@redhat.com>, 
	Stuart Hayes <stuart.w.hayes@gmail.com>, Laurence Oberman <loberman@redhat.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 4:02=E2=80=AFAM John Garry <john.g.garry@oracle.com=
> wrote:
>
> On 20/04/2026 16:26, David Jeffery wrote:
> > This patchset allows the kernel to shutdown devices asynchronously and
> > unrelated async devices to be shut down in parallel to each other.
> >
> > Only devices which explicitly enable it are shut down asynchronously. T=
he
> > default is for a device to be shut down from the synchronous shutdown l=
oop.
> >
> > This can dramatically reduce system shutdown/reboot time on systems tha=
t
> > have multiple devices that take many seconds to shut down (like certain
> > NVMe drives). On one system tested, the shutdown time went from 11 minu=
tes
> > without this patch to 55 seconds with the patch. And on another system =
from
> > 80 seconds to 11.
> >
> > Changes from V13:
> >
> > Remove duplicate flagging of async shutdown on scsi hosts/targets/devic=
es
>
> Please mention the baseline or branch that we can apply this. I tried
> Linus' tree, but it did not apply.
>

The patchset was against the Linus tree, but is no longer recent
enough as a driver-core merge conflicts with patch 3's header changes.
I'll post a rebased version of the patch.

