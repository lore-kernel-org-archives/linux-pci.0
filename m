Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD96341660
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305987; cv=none; b=oT0owBzl3qNka93Td7Pai4DOI/GRiFHzn1/CnBWgiRjxGXgRmaoINV0OM7f+3T/4v96YdpHmWOl4Gbij6wtO4GyQ3mEetNe2lTWwv+UsI15PJNsWCifbkGkx1b2yRVkzwSM7E9vdE/y2Nc2ohLtSBsqTHhTs43I9Q369ZKfsTHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305987; c=relaxed/simple;
	bh=mzDS5S4lHKbGJcbG+SViaOsHQqXsul/yOTgWjqhBimU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/4mUkWH8wm4LbuFr/3HxP8rblHmUHL2pNEen/HGJmkkVoedqN6CuhgT1lDcSiLnrNk1A2sKDGaLjIMVUmm3gSwsVZykI65dLIv3F/kPXa0mzVW0loeyO7C+1DeYWo7oPnBpzH0n6xV3PWOh3U57CgmmaUicWoUfKnAKc8Sbt9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIJI6Xjv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIJI6Xjv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38F9C2BCB4
	for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 16:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777305986;
	bh=mzDS5S4lHKbGJcbG+SViaOsHQqXsul/yOTgWjqhBimU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jIJI6XjvxqQ8gWhn/tzGAsCUyz5EryYodCLSgPkrfzLK9DwAjfmIUjCSvpPj9JeZ8
	 enRWk4cp7R7/IqhpO0Lqci5DP7T66uf1My+2mZgdi++O26qSGw9ZvLRSOSIBnPRjQJ
	 sRb78X/zyUxSWjDnmk5Cv5W3Vif1UBtD/4ujIqYJ2TIZ1RmPgL8xDZhQJM9/+IPJQp
	 AXMnsr4BcJnHRd9vTrrdcC7FQ7rsTYbulvmcAmODGNMUozVsX/HTybekF0sPAeszyV
	 mpv5kpBvT9ryyY5CBseWyujl8HyCF+JSdQuPOW4ZWwr9nPxEJ5jYpmU16rflLZ1piL
	 1ygSDTQBQc3EA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso10683499e87.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Apr 2026 09:06:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8MylaXgu/6M9kJ9D+tBh2wO/DpRx4J+zTqiqEkxx0HBofbvz7gVdaJK2zJFAZQ9eo+yhHVhwF3tdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqKdKsdZoJM62BlbedjRV1kp+c4513ymHLsSiFnI013NXneEg
	xnF/tobNVakwYnpvp7LpaaAYTLCtvKK9HZtrbPljeACGTFoebXFTc4jY/BZAogyI97YvRmY/qEp
	jgIgC+4HrS/tfHaeqGENU2vxPzkf4Ihk=
X-Received: by 2002:a05:6512:3984:b0:5a4:ab6:81b8 with SMTP id
 2adb3069b0e04-5a4172e7fa9mr10923960e87.40.1777305985264; Mon, 27 Apr 2026
 09:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427035341.1425576-1-superm1@kernel.org> <CAJZ5v0jMBpXC5BxjdMgpg8tMKpS3Hf2MO_MGNtdS_S+s41jx+A@mail.gmail.com>
 <ca274454-b58b-4837-a3fd-14ef30c24510@kernel.org> <CAJZ5v0haau7219McDX8d1KhS_ig_nPDVNEV-w0HWMe_nMCjkpg@mail.gmail.com>
 <286b39c3-f368-4477-bb67-2ce53f62d6a3@kernel.org>
In-Reply-To: <286b39c3-f368-4477-bb67-2ce53f62d6a3@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Apr 2026 18:06:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQX7oRBOkOiF6R1chdYA_outw7W2hQ_dWB02dftTvf8g@mail.gmail.com>
X-Gm-Features: AVHnY4KL77CBX2eOvzOja-rUlowIlR2w4LDNvaWH1P3TwbK7iTivGwG87TWNUeg
Message-ID: <CAJZ5v0gQX7oRBOkOiF6R1chdYA_outw7W2hQ_dWB02dftTvf8g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improvements to PCI hibernate path
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 5:19=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 4/27/26 10:09, Rafael J. Wysocki wrote:
> > On Mon, Apr 27, 2026 at 4:14=E2=80=AFPM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> On 4/27/26 07:20, Rafael J. Wysocki wrote:
> >>> On Mon, Apr 27, 2026 at 5:53=E2=80=AFAM Mario Limonciello (AMD)
> >>> <superm1@kernel.org> wrote:
> >>>>
> >>>> A few cycles ago I sent out a kernel series for using the S4 paths w=
hen
> >>>> the system goes to S5.  Some parts of it got merged, and Rafael sugg=
ested
> >>>> to split the other parts into smaller pieces across multiple kernel =
cycles
> >>>> to make bisecting easier.
> >>>>
> >>>> This fell into my backlog behind other things, so I wanted to try ag=
ain
> >>>> this cycle for the PCI pieces. I have been carrying it, rebasing it =
and
> >>>> personally using it for a while now though.
> >>>>
> >>>> This series attempts to unify the PCI suspend and hibernate paths an=
d to
> >>>> fix some things that I observed to be wrong with how I expect hibern=
ate
> >>>> to work.
> >>>>
> >>>> It is based off 7.1-rc1 + Lukas' patch:
> >>>> "PCI: Stop setting cached power state to "unknown" on unbind"
> >>>>
> >>>> Mario Limonciello (AMD) (5):
> >>>>     PCI/PM: Disable device wakeups when halting or powering off syst=
em
> >>>>     PCI/PM: Split out code from pci_pm_suspend_noirq() into helper
> >>>>     PCI/PM: Run bridge power up actions as part of restore phase
> >>>>     PCI/PM: Use pci_power_manageable() in pci_pm_poweroff_noirq()
> >>>>     PCI: Put PCIe bridges with downstream devices into D3 at hiberna=
te
> >>>>
> >>>>    drivers/pci/pci-driver.c | 103 ++++++++++++++++++++++++++--------=
-----
> >>>>    1 file changed, 69 insertions(+), 34 deletions(-)
> >>>>
> >>>> --
> >>>
> >>> It would be good to CC this to linux-pm.
> >>
> >> Sure thing - if there is a need for a v2, I will include linux-pm in C=
C.
> >
> > The thing is, you may not know if there's a need for a v2 without resen=
ding.
>
> I would think Lukas and Bjorn will at least have some comments and I
> want to give them some time before cluttering inboxes with a second copy
> of the series at the start of the dev cycle.

Fair enough.

> How about if it looks good to them as is I'll send a v2 with their tags
> added for linux-pm to get a chance to see and review as well.
>
> And if they have feedback I'll incorporate and v2 will also go to linux-p=
m.

That should work, thanks!
