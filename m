Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007F472F6D
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 10:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542981; cv=none; b=C29NmVsiSDgJH+vrb87quomasTJ3UuSTzo3Vt5sZR6lH9fzViY83mVjNYLhCzevUEapq6fPsZ3EOFKu3ipBN5UJ5Y5e5YhwPrdVvYESdE16z7JS9VmRuj4SMPyxU116kjiygMrTnO6Rv82YeQd9YRrRIwIb4m4yFz1Ajzx8CTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542981; c=relaxed/simple;
	bh=SLLtsuJDTlq7Fr81Gu8AVjmVGtv1CElSkOkCkDp89FU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XK0LYMdZo30r9yH4lBh5J3vQvLbV57NMYmviHViQX2j72MDu5/K0kZqP7BCcFtwwY5sH6ozi+1btpNQsEJG6x4aI1EJNIUetmhZqQ53DjSBO3MOO7wQrxy797nQbBM1dRY+S1BACal6X3r1bYwe6Z+JmWVtfL8opOseGhdDuRrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Ukzwlcs8; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Ukzwlcs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1791542961; x=1791802161;
	bh=SLLtsuJDTlq7Fr81Gu8AVjmVGtv1CElSkOkCkDp89FU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ukzwlcs8PS3VqOKk5W8iuazLeGDGj0B2A1YaHyummCpq+2SmSrNA4IfE6RnGQK8Hs
	 Me5S3YuUMfhKIST3xXXNXegfDof06cXW8QetH+H81/5wlPR28VOHGQOOtxgjFQChkg
	 cOuIgMrazG2qMFq3vL4zaav1Aw8njyv/2uSGOipxGE5HRDDd3yoX0xLWfAkwHZnQu6
	 dlIw/bw0G0x7jJB9x12vYkhAs+CL0KrD94Fsd4qFLO+T8Dta6unMZU7SOFWVYDwZWO
	 bRWrUmNwg4WeaSp/Fr8e6ctRRwlpp9AJ5xmPRNWWq6tkL/XaxlSZD6NsYNdYqXu/+S
	 Aqv2txVU+VEpA==
Date: Fri, 09 Oct 2026 10:49:14 +0000
To: Qiang Yu <qiang.yu@oss.qualcomm.com>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
From: Birk Skyum <birk.skyum@pm.me>
Cc: mani@kernel.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: X1E80100 USB4 PCI0 MSI-X routing under EL1/Gunyah
Message-ID: <179154295092.57137.9886798511530035607@pm.me>
In-Reply-To: <179146327547.21465.818931382318963045@pm.me>
References: <g7V4kc2AO9xogkH0h-XHDvPbjDXcnS11cp1q3hv0X96KPW-zed6V79HUJY5BFA4pBWUE-p2MBYCeDcjWwUGBIU2hXjDpodiWaxB38obe8RE=@pm.me> <arEjxhvfIFGGo9O9@hu-qianyu-lv.qualcomm.com> <C8SBDdV0hyOxs4G2FfZBHt4_1PSRVoxaNFSmy_riJk91MhqFMRAt30lpxdyniPMLWnc5Ph93lS0R1nCkVbuV941UrNmWyPNbDER9zIHlrJg=@pm.me> <7PyP8TPDWSo4VXsNVgDQREx6MqiqQWWL_BsssgI4SBuA9jkR707AGw5AVnm6k1OgH6F2n6Y6QAxah6ZRtKpjZfIKOiOngog3eeLFXIXXf44=@pm.me> <179145909457.22346.16055361038608923365@pm.me> <179146327547.21465.818931382318963045@pm.me>
Feedback-ID: 21326998:user:proton
X-Pm-Message-ID: 00fb7baa50ada97500e789bf5ed70170d38d9296
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Qiang, Konrad,

One more follow-up, this time on suspend.

With gcc_usb4_0_gdsc no longer always on, a system resume powers it on
without the router driver being asked. genpd does that in the noirq
phase for every domain with a device attached, whatever the device's
runtime PM state, and switches it off again afterwards. Our stop still
held GCC_PCIE_0_TUNNEL_BCR at that point, so the GDSC driver reported
"status stuck at 'off'" again and the router could not be started again
in that boot.

Releasing the tunnel reset at the end of the stop, before the domain can
go off, fixes it. The Yoga Slim 7x now sleeps and wakes with the router
powered down and with a drive connected, and a drive connects again
afterwards.

Konrad, this narrows what I wrote on 8 October. The tunnel reset has to
be released before system suspend, not at the next start, because the
resume power-on comes from genpd.

The deep suspend hang after a router restart that I reported on 23
September has not shown again on these builds, in three tries. I have
not found what caused it.

The report and the two patches are at
https://github.com/birkskyum/yoga-slim7x-usb4/blob/main/docs/USB4-2026-10-0=
9.md

Thanks,
Birk

