Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11733CA4BD
	for <linux-pci@vger.kernel.org>; Fri,  3 Apr 2026 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233161; cv=pass; b=igF1m/ecOKlmmHfCXQ24ezJoTejDmqAeNSn/oC6Z5JMCrafvk17JyJcgk0vEplRTyJu/2VYYeEIfODrtvGJQXaO7X/jJcWd/Be5D5qzbJzwa8AcpBPsaqEoyDWiTUWnWSBLhHEL9/OpdSeUg2ONNlO+IMEE8JzteEPA3f2kZrO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233161; c=relaxed/simple;
	bh=L30/b4+Gyh2roINFrjR8Nr0vV0xKSjAAnBDD3nswarY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMheopal6ZyjPGZ3HGcaeZL4ogCk/n9p1zjQXODu+Dnz8x2SlCmldUKNLPcsmfl8pel3lL44i1h8RSz1fZUnWp/avl8ZK8loghyqHxJYKKRbwcCmCRIOrxYp7LBXMGOzq1ou+5J+S98A5sZMsm8VM6J1wosUg0d8RL92bL2Y6hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me; spf=none smtp.mailfrom=joyfullee.me; dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b=IgvPzJ4e; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b="IgvPzJ4e"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66deafdcdc8so3290545a12.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Apr 2026 09:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775233158; cv=none;
        d=google.com; s=arc-20240605;
        b=bHc6movjH48rAgwmqbRkIef5rQ9h6URvc4SujAqMdtNa3PXUm6t6LonQXIILu7Ij2O
         FsRTd1ggRc7MvNufOwxYLx1sAv1730NtpmA4qttypNBxMcwHIIInIBvrTIvfsrPh5EwW
         GkEXocDfMfyh433GyCOnvDzmxKlyfJ97k1nWlWZFXeU5gpQUpmU7H34pWJUeAs4LTm2r
         j7Q3keh9Xve52B9RwaTnk55Ze9HSJdpQrHfKBO8UbxHoZQ+p53kkHEUsYo0pOJjC+wJt
         FV0rgLpPxrt9ed2v2ZCWwLRQNa2TwqCR8VryNtP8iH0at5+3mnnoyBveD1D19rbOYCFw
         hAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F3gZOk0u2GpWeeWhIugCmNU2OqtSSo0NtKnU+5FZ5cU=;
        fh=uFo7QPqj4owRiyjwLao6D7+Q16BpAdYnkqtTqz5EeZM=;
        b=QvBbxXDNRoJP21I7Z6lsoQlhWUbxq7Gx6rQjee09DQg7VLJvY039uRTZ8qCchdp0RR
         dEDGwOZpvucHVuhVcEn3osPxs7HJrFFJVAKLpBaqJQMXajZ9udcxy7O0JzPQy6VHlilr
         xjNElvEwlMGmZydB6zg/ZmECo7wbWpC9L2eN/8ck4WzjH5LHc+xZQdN8tJQXk0Ubleze
         KWwKTsHCaYP3IWRK8Oxczlqotj8GwEHfk299pTWbiqpLwIxaRH7HeC71kMZSXBfz1hjE
         b8vfVasXwkZRHSVz/3XKA0XpPMtDiZIt+s313I77Aw+gtwB5r8iKhNXErYgU59CTe5oJ
         g/KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joyfullee-me.20251104.gappssmtp.com; s=20251104; t=1775233158; x=1775837958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3gZOk0u2GpWeeWhIugCmNU2OqtSSo0NtKnU+5FZ5cU=;
        b=IgvPzJ4ecaieqx8gqzpxkFIAvEerdRagxmjw7ONA5GKWwmmA4Nb+Q3LhouxAXs5bCl
         ettdniV89+VdyAIYkhZ30Ijtbcp6lxJUogXLfTMbHfk1YcwdxTQnG9eK1yuWW4EEpo9l
         yeJFbvnGNg99jghzixMd++LH8lMZlEFG8JSydQflp4rxAwnqS9UhSSp7xB0irc6aanD4
         r5jDfE9LRWZ4sZQJk3B9HUpG5Ts/dm42QdyZ9h8GzZx8wsGAFzn1NJ/ERb23ENAodMyo
         +bPV+vcjaCfZIqyCbffd5z2escXOuO+jy1B3wOScAiv5PVMYwizzD8/cMIg5dNY9D/zn
         edww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233158; x=1775837958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F3gZOk0u2GpWeeWhIugCmNU2OqtSSo0NtKnU+5FZ5cU=;
        b=ViK2g1O0UPa0F5KzOwor9RHnWvp9yb2haAB6UrY3nZ/g3OyJABCr9ayqeu0+idHVpw
         MNu78Hzq7CBeeATrj/eITsktcl+FqEXr3R8Y0dunkHCwQOnqPdbuqQIqKJJ6fZnDEH5Q
         ppkU6bu+Mof31N8+ivlmsWXEqdyNW8LKXrDu+ep61bBfsd5AsDgBiW7oTPaMz6m3cClV
         ADLlQq/e/PtkS++TwNcXwkVvJ5A47mhunZLSat4jDgROITEdQJo7WrhvoBZNTtPTq7WR
         sQ4u3LOB/gwjU8TesO1NR+anKBZKf1UcSx2EygHiWwFZgfq0yeClq3H8XjOXwG7lTBBs
         Bscg==
X-Forwarded-Encrypted: i=1; AJvYcCX1sfF9hF3gxA60iWNL+io/MKGtt3tIfl8wGgFsNJ1nY+o2G1Q8Bxc47X9Cmk9/WoTMKZDMtagRzK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydOiGFW7y1WsVTbkZzd5j5iH8Xwv9iwnE6rd7AH6SzmyXMi2RS
	k05UgY/QWmwWg/OGNEw/VRUZpRsV6GrTKnA7e36CrRSFF/4jH2nTJx9nFaVdG5L42tsgecCMViu
	YShXDqMvEX0vWYOJPBhN7scTwFRVZtXb5YiPZS8Aiog==
X-Gm-Gg: AeBDieucfnSKF++RIh3jh5RIQCGrYvnUuQ/D5tzZCcL2Y14dVuZAuRudK1Y6wJaPFep
	aRDf/k9ZpMHdwl8yVhZna17wIDX82GwGdZtJTR0SoSFtnI8umzy74yzlQjlkrto2RMzZIYdoOOz
	aY6oPGBaREuRwpIkWNe+6cMdC82/d/yiwsd6RzYF68Ae/vYHKMWQA+lNMNJvkStNChNn0SX55Je
	X3wUxl9Eb4t7PKkzKpgznUnisA+3oJRdNleuxwaykngV+awS7G90IY3bRN/CSLPYxwnnxZnCGDR
	Eucu2g==
X-Received: by 2002:a17:907:6d1b:b0:b8f:848b:4456 with SMTP id
 a640c23a62f3a-b9c6742299emr177158966b.13.1775233157953; Fri, 03 Apr 2026
 09:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com>
 <a935b2e3-e11d-47ec-af47-7eb7e86a9dd0@amd.com> <CADj6jrgcuz=Bcp0q7BHVizVeF=C2r_8qXw7r0Mc5X9Vd8uWK-w@mail.gmail.com>
 <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com> <CADj6jrgse2NksUgkHUzTm0332ba4qnV=0QOJAnupS=Lr=5hh4A@mail.gmail.com>
 <4978c9b7-00bf-4562-baae-098bd0d09ba4@amd.com> <CADj6jrh2AT6vvQqujB5UN5tfcQ-qdDKjV_7fK18zsqkHpFTMzw@mail.gmail.com>
 <867b2fa7-a8a4-44ad-aee8-fbb9d0555072@amd.com>
In-Reply-To: <867b2fa7-a8a4-44ad-aee8-fbb9d0555072@amd.com>
From: Joyful Lee <joy@joyfullee.me>
Date: Fri, 3 Apr 2026 12:19:06 -0400
X-Gm-Features: AQROBzD_0zG6UUOBfCeJDvISibakR2t2dYw6Xl5_Zpv1OrcQrZkOco2YmA-Qx6Q
Message-ID: <CADj6jriuyztRnB60awqyhO-hu18mZ+UmpMsY+_qnSYPkcGqDSA@mail.gmail.com>
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 10:25=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> That's really unfortunate to hear.  If I was in your shoes - If not
> solved by the end of the return period I would return the machine and
> purchase one from a vendor that has been testing, fixing BIOS issues and
> supporting Linux.
>
> I'm not going to pick favorites, but Dell, Framework, HP, and Lenovo all
> have offerings that they do this.
>
> By chance does the BIOS offer access to "AMD PBS" or "AMD CBS" menus?
> If so, there may be an option nestled in there for dGPU D3 behavior.

I got it working. My kernel, which I build up from defconfig, was
missing CONFIG_HOTPLUG_PCI_PCIE. It makes sense, but I wish there was
more evidence that pointed me to this option. At least we can close the
loop here in case anyone else runs into this problem. As a side benefit,
enabling this option also got the dGPU to enter D3cold where before the
lowest it would get is D3hot.

Thanks again,
Joy
