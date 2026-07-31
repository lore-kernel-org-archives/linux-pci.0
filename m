Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEDB356778
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503076; cv=none; b=Wac08Tkj9KnkWkFf9PLnKv0kT4p2jk4G3p8FWJjYg+ZHPxpcREDaN22tn4hzuCtPosu0nnjvl7p4ZRuYGEgqzO6MihUPX5xRPogEnbCjxx0rs34dPvN/QN/4h04pSrHfZXloC3QNQ68Og4WPQcMqN/6Y5fPkSnGVEH2e/qkVT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503076; c=relaxed/simple;
	bh=pJXXlYng5KRlwgquFu+DGy8KkkZm2v71nQREvSXkIp0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/5M29Vs7qfXM7gi7RUUVC4PWvjSBEQ5oupZDp06r4NXavyN6dUTrYs510OHEP0Zv+Lr8dtFVZQ4T50AR3SImxBCFkTKbHes8rXjb8hrH8hxJddNrldlHS6KhNx/qatbuEMaz1W1UrxjwA3USIMUSbwvvWgm49f+lJbwHhOMlAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDTY8SSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDTY8SSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174041F00A3F
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 13:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785503074;
	bh=CjVcHniSLBRKWrFsvh8Ah11kb/c0CCbICSTiExfKTL4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=kDTY8SSg2DvDRu4yerj6P2/KRGWPXKPVdCkx3GGtU+QyCTiEF3B+6cT/A8fXVC9J8
	 4Cs7lYME0Gr0Zof98cYuhyP7NKFllsvmKYY9l+exMH9vTpuE4gguSk5ySlsy7nQCrb
	 F7TKXLgpm3Mg6E7ev0rPBSmSa9LHkreXpNEScPPJ2bJ59j7nzrllJtEW+zeF63rqem
	 9/YrjsWFaWM7gPyh7a0kiitUWSv4XnO3kD6qYXY5Pkc56p2Z33LDrKvm/PxyX01O6p
	 TW0mud+0y728uJ7Boxsv5sNUCzPKLomkOvyTwNz1g3SaNnOakHNLxj+hdcYGY/KCSf
	 1E4yWCAJLqMyQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c7ef2b1e2so8940641fa.1
        for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 06:04:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rpg0p3PXo9CUgDqva3X3UqSy1emh5nJdghYFKMI4lSGHZdxVGd0facoVWznF+h0yjtyWGEBzL2eW6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YynQ5bkgJnetSULHqrMRBvTrfR1+F9ThzFD2mYYMNxN0UdplpDY
	KAzQHh7hIPI/rcASV4oaEotfOav4KVvxFj6zy3ICLs0cKX0cOOjmQKMru3WUyQ+XyZBKNoixBEb
	Jl0JILgEua9xn3IUf1WQncV2UiEhl0hlr/cnXSeGOcg==
X-Received: by 2002:a05:651c:4396:20b0:39c:a06f:12ba with SMTP id
 38308e7fff4ca-39f7e44b426mr2905841fa.40.1785503072391; Fri, 31 Jul 2026
 06:04:32 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 08:04:30 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 31 Jul 2026 08:04:30 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAFEp6-3X+PCXZdEy1p47XUDs7cT16JDjt0=928Jjkeik_haaQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731-pwrseq-vote-rename-v2-1-480357946e00@oss.qualcomm.com> <CAFEp6-3X+PCXZdEy1p47XUDs7cT16JDjt0=928Jjkeik_haaQw@mail.gmail.com>
Date: Fri, 31 Jul 2026 08:04:30 -0500
X-Gmail-Original-Message-ID: <CAMRc=McA3BqoazxvGDu1_WoT9x0ujXT_80jKPp+5Jb0Rda9zOA@mail.gmail.com>
X-Gm-Features: AUfX_my34O5ZqodmTjdz_FwlJrp9NnalnGl6Ep4FvspsE7xopR-UD4qRTMMPUOE
Message-ID: <CAMRc=McA3BqoazxvGDu1_WoT9x0ujXT_80jKPp+5Jb0Rda9zOA@mail.gmail.com>
Subject: Re: [PATCH v2] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Alessio Belle <alessio.belle@imgtec.com>, 
	Luigi Santivetti <luigi.santivetti@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jeff Johnson <jjohnson@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
	linux-pci@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Jul 2026 10:43:19 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> On Fri, Jul 31, 2026 at 10:29=E2=80=AFAM Bartosz Golaszewski
> <bartosz.golaszewski@oss.qualcomm.com> wrote:
>>
>> The way power sequencing works means that a call to pwrseq_power_on()
>> does not necessarily result in the pwrseq target being powered-on at
>> that time: it may have already been powered on before. Similarly: a call
>> to pwrseq_power_off() does not have to result in an actual powering off
>> of resources: there may still be other users that requested a power-on
>> before.
>>
>> We will also introduce the concept of "non-controllable" pwrseq targets
>> soon which further increases the disconnect between the naming
>> convention and the actual semantics.
>>
>> What consumers of pwrseq descriptors actually do is: they *vote* for a
>> powering on of a given target or retract that vote. These operations
>> could be called get/put in line with runtime PM but this could become
>> confusing since we already provide pwrseq_get/put() for a different
>> purpose. pwrseq_vote_on/off() also have been rejected as unusual in
>> the tree.
>>
>> Change the name of the two functions to pwrseq_enable/disable() which
>> better reflects their purpose and semantics and also mirrors other
>> enable-counted resources like regulators and clocks. No functional chang=
e
>> intended.
>>
>> If at any point users need to know *when* the exact power event happens,
>> we can provide that information in the form of a notifier.
>>
>> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com=
>
>> ---
>> I've floated the idea to rename the two pwrseq functions from "power
>> on/off" to "vote on/off". I've sent a patch but the overwhelming
>> consensus seem to be that enable/disable naming is preferred.
>>
>> I'm doing it in a single commit that should go through the pwrseq tree
>> with Acks from subsystem maintainers.
>>
>> [1] https://lore.kernel.org/all/CAMRc=3DMefxn81d0VUwmQgwFtffkL1=3DEr_1VQ=
ZCbC1Sa-Qph4t1w@mail.gmail.com/
>> ---
>> Changes in v2:
>> - Change the naming convention to enable/disable
>> - Link to v1: https://patch.msgid.link/20260727-pwrseq-vote-rename-v1-1-=
a2029aeeac65@oss.qualcomm.com
>> ---
>>  Documentation/driver-api/pwrseq.rst      |  4 ++--
>>  drivers/bluetooth/hci_qca.c              |  4 ++--
>>  drivers/gpu/drm/imagination/pvr_power.c  |  4 ++--
>>  drivers/net/wireless/ath/ath10k/snoc.c   |  6 +++---
>>  drivers/pci/pwrctrl/generic.c            |  4 ++--
>>  drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  4 ++--
>>  drivers/power/sequencing/core.c          | 16 ++++++++--------
>>  include/linux/pwrseq/consumer.h          |  8 ++++----
>>  8 files changed, 25 insertions(+), 25 deletions(-)
>>
>> diff --git a/Documentation/driver-api/pwrseq.rst b/Documentation/driver-=
api/pwrseq.rst
>> index ad18b2326b689a41471216f3889480b11768ca82..0c315ab1138b02540fae60b3=
9928c580027c0f7c 100644
>> --- a/Documentation/driver-api/pwrseq.rst
>> +++ b/Documentation/driver-api/pwrseq.rst
>> @@ -50,9 +50,9 @@ Consumer interface
>>  The consumer API is aimed to be as simple as possible. The driver inter=
ested in
>>  getting a descriptor from the power sequencer should call pwrseq_get() =
and
>>  specify the name of the target it wants to reach in the sequence after =
calling
>> -pwrseq_power_up(). The descriptor can be released by calling pwrseq_put=
() and
>> +pwrseq_enable(). The descriptor can be released by calling pwrseq_put()=
 and
>>  the consumer can request the powering down of its target with
>> -pwrseq_power_off(). Note that there is no guarantee that pwrseq_power_o=
ff()
>> +pwrseq_disble(). Note that there is no guarantee that pwrseq_disble()
>>  will have any effect as there may be multiple users of the underlying r=
esources
>>  who may keep them active.
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 345f602e9ce233a0934a73a85d1e7c17c4f3210d..e713fc06b73402ae3d57794e=
d0870df8394a796a 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2259,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
>>         }
>>
>>         if (power && power->pwrseq) {
>> -               pwrseq_power_off(power->pwrseq);
>> +               pwrseq_disble(power->pwrseq);
>
> Nit: s/pwrseq_disble/pwrseq_disable ?
>

Ah dang it, how did I miss it, I test-built it. :/

Thanks for catching it.

Bart
