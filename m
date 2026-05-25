Received: from mail.mindbit.ro (xs1.mindbit.ro [80.86.107.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE32C11FA;
	Mon, 25 May 2026 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.86.107.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779728213; cv=none; b=FLe9h+y4Y76B+4vU+w7cXbF1JlFc4k+clo7q3bjyF89zJOrpkMUFvbk/VcmgEutezSOETbBCVCzozVrpvnFaOZnz46550Bj9XPMaY1CqTECPTX0KC3XIZWGZ9RLyDBkGQSCVZHm/uM3mEhx1nYQUONOSL9PHuDe5du9jOWOT4xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779728213; c=relaxed/simple;
	bh=kF+DgLzJq/8tfSh9UBbLv3L4NBQMEM8NeQ9MGaPsLQ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNAwQjs9Urgc9fVP5UFfokmLb/2/hK74flKQQIJc/4Z6cgKA4DGZzEsM/vK8r/CUWsz7qdoT8mEtJc3Q+SVnyMZaJxPxNaEw2cXj+1whDEPXpSxBwe58u6BHeXU2G2Nb9yBWpczmVM4yydpzunxSWPRRIjRClPvpmM6CJKW8Khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net; spf=pass smtp.mailfrom=rendec.net; dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b=mwSOybtg; arc=none smtp.client-ip=80.86.107.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rendec.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rendec.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rendec.net header.i=@rendec.net header.b="mwSOybtg"
Received: from bat.kanata.rendec.net (unknown [24.114.102.244])
	by mail.mindbit.ro (Postfix) with ESMTPSA id 911DAC2879;
	Mon, 25 May 2026 19:48:14 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.mindbit.ro 911DAC2879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rendec.net;
	s=default; t=1779727702;
	bh=kF+DgLzJq/8tfSh9UBbLv3L4NBQMEM8NeQ9MGaPsLQ0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mwSOybtgz+3VfvezLohBO0EFwznohj1Up17/JQuBZdVwJMLgzSkAl7iq7+0YvlvWF
	 Zc40+fVl5aWL9pCXmpCaUKzjvPrkd6yvp5bolQwcsCc6sUJBzkTF/2cCb7p9JKU7xS
	 +XObKI6M38MrvvYTk+tnMLuysgdC3xPN1886frtmCWg1zstWmFF7s/UjwBu5AfFnTu
	 yDLV9ErcqntgsFS5Yf+Ew6xwaKgiPAwjc0iuA2CIjRypkik7moXU62pKdriqJDB7Im
	 Up95l9rPc+VJlnFW948L8qAhvFVOO2DoGNEhmpuhfIVD42pH5/lZSheDyCF5ZKQz/D
	 XpjzIlJglpv6Q==
Message-ID: <73f04f467e65b13fd455a3650dc2bd106af1e5a6.camel@rendec.net>
Subject: Re: [PATCH v3 3/3] PCI: dwc: Enable MSI affinity support
From: Radu Rendec <radu@rendec.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Manivannan Sadhasivam	
 <mani@kernel.org>, Daniel Tsai <danielsftsai@google.com>, Marek
 =?ISO-8859-1?Q?Beh=FAn?=	 <kabel@kernel.org>, Krishna Chaitanya Chundru
 <quic_krichai@quicinc.com>,  Bjorn Helgaas <bhelgaas@google.com>, Rob
 Herring <robh@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Jingoo
 Han	 <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>, Eric
 Chanudet	 <echanude@redhat.com>, Jared Kangas <jkangas@redhat.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 25 May 2026 12:48:09 -0400
In-Reply-To: <ahDvvGew5UK3KSpi@google.com>
References: <20251128212055.1409093-1-rrendec@redhat.com>
	 <20251128212055.1409093-4-rrendec@redhat.com> <ahC8Pyuatu_AvnZp@google.com>
	 <ahDvvGew5UK3KSpi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Brian,

On Fri, 2026-05-22 at 17:07 -0700, Brian Norris wrote:
> (Updating Radu's email; dropping another bouncing email)

Thanks for doing that! Obviously, I no longer have access to the email
address that was used to post the patch, and I was lazy in setting up
scripts that follow the mailing lists to catch messages that are
addressed to me directly but using old email addresses.

> On Fri, May 22, 2026 at 01:27:43PM -0700, Brian Norris wrote:
> > I'll see if I can learn anything more here on my own, but I figured I'd
> > report it in case you have any thoughts or leads I should investigate.

Thanks for reporting it! I do not have any thoughts or leads yet, but I
do plan to look at it during the next few days and hopefully come up
with something. I also apologize for the slowness in my replies.

> In an hour or two of poking, all I've learned so far is that the problem
> also seems to go away if I:
>=20
> (a) add a few dump_stack() and other noisy logs to a few key places (for
> =C2=A0=C2=A0=C2=A0 now, __pci_write_msi_msg(), pci_power_up() failures, a=
nd
> =C2=A0=C2=A0=C2=A0 irq_chip_redirect_set_affinity() -- I think __pci_writ=
e_msi_msg()
> =C2=A0=C2=A0=C2=A0 was the most significant, possibly because it produced=
 the most log
> =C2=A0=C2=A0=C2=A0 text) and
>=20
> (b) leave a 115200 baud UART kernel console running.
>=20
> (This is on a sample size of 20+ suspend cycles, whereas previous
> bisection would fail 100%.)
>=20
> It then reappers when I quiet the kernel logging a bit with `dmesg -n3`.
>=20
> I think that simply tells me that there's some timing issue or race
> condition involved.

That's very useful! Interrupts are migrated on suspend to the main CPU
and then migrated back on resume, and the ordering and synchronization
around that is tricky. The stack trace in your previous message tells
me that the nvme driver is waiting for IO completion, which is normally
signaled by an interrupt, except that interrupt never arrives.

With my patch included, the demultiplexed interrupt (the nvme interrupt
in this case) has an opportunity to be migrated during suspend/resume,
whereas previously it did not. That's one more moving part, and I'll
have to look closer at the code and think what could go wrong. I agree
it's likely a race condition or a timing issue because it works with
that extra logging, which adds small delays as a side effect.

Regards,
Radu
