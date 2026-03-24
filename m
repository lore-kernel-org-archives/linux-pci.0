Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9B392822
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379704; cv=pass; b=MUMZ3BM2TjijrXx1pVbxT4MIZ2DOdM4xKkGn5uT83Opsdui2/FiV4RmDAGfV/Mz58XRRHyjeFUKLL6wm4AycwEiJyFY3qETXRAH9fmMynrOm20HSceoQqNmD7AABiesPEElsqetzXHVHsg8sU4ecjjPv5g/QET5fgO7z6IIbejE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379704; c=relaxed/simple;
	bh=mXQH2e7ey4FhEPRcJoszhO0ePG1FdnyzQZjdgRZXj+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaIeh1JuDGQvy6FQL/poGIUnn+e5u92MmALAfYMTqFogfZWu1DTLXdLE3S48oNSo+rVWwilzeHbuHFR/oa6kBZ02vk1ZrHDyrDlPDkMwatIxyH6NnM70mhlf5eO6UkXaEgu2BKImYDNVdjqSn46VF/mkbct1HDFSQcPIVrenAYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=lRGmo3NE; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="lRGmo3NE"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B56E63F618
	for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1774379692;
	bh=ngqb+DmGtwEG3FK8sIpZyt2ZJ6Tw4EzBiHu4t/MVsn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=lRGmo3NENOanaizI5i0CxuJcJ2E31k1e7sB4scygqi5w085Ync+2hOaajcrdnQU88
	 4NcbiTuCxJ9fd59kT5R3K75i9TDezETUeu7vxL0nCOwiC3PgNzn2IeoxIr+5Yimj6f
	 +QuLClm4Iq8VphFXjgFSHk8B5qPiiMv7acTzhFWZdqcj7+haRgyAn1PaTzQGhkKDDE
	 36yd31HTp0Qq7un2CKXwwHhkU1CSrwviHzkA+E7dP4Hz9+k8DWv80KZF3RpxKZQIN1
	 spj1pbc5aPXuZhsKwkuC0jZZyR15F1X0FjG//4rdVicPTIKSzMJr7SHRus2cQP35Uv
	 y04E/ydMWLqPM7y43+PgefVCmjiIeHvyWUGxw+Txpu5MPAbZCgRoZoiPPeCAeUq1Z6
	 0X91StoXC9FHFDjtMZWe8p3QVmJcOcOl7fybueD56lFNe5XIvUIh1bhP4T2r02ZvdI
	 2FFxklQe3uPHmNtnOsRPfCEZMHHvES+eED4jeyp7bH0MGMiFROOh9bqwsi9NsPCaIn
	 yjhNvvmf++jRaN9dzBnPY/Upom4vHOl2w28WjqzU8CgkZUx9o6iRDwYK2e8t9BVWmN
	 eAvnzC6fN+tqSbRrmuvsxNYAa7oYGSvFjyrFqJ73XRjjm0O0Vpyi1NIl0dZGhCkh6P
	 p3aQmdFrSiCiel76MYX5gfjA=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b97d66528c9so25080366b.1
        for <linux-pci@vger.kernel.org>; Tue, 24 Mar 2026 12:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774379692; cv=none;
        d=google.com; s=arc-20240605;
        b=gRNEfzld9lgdanf/CAJ0PZ9sSnjHqkBgjnOqrPk/XITMFWMBF+BycBIpCGU9xM+bqW
         2ss2kZhUFAEG9PbLarEU1fG9cZFa10LhGPz3PK7MrnhzLMTxLQkoRY5iygiXopZTbqp+
         oawf01InxitW53RF7f5a2YmclPyOjZ1UThT8hQY+P73IPM0AirrlgP8CCykScLtb8k+m
         4odUhsNyDKeeQe4VZv26BeenFVdf4bFMG52ZwdbOCFPzw/c0hkUyErzebvJelRg338cB
         h7tBfaUua+lwOjrhLt/Kv7ETkpowUszb5r1h2fEW5y1c0U8jdBCkv/eSotv4lbsvt7P0
         uYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=ngqb+DmGtwEG3FK8sIpZyt2ZJ6Tw4EzBiHu4t/MVsn4=;
        fh=5A+Ca96kcwqrq7MjwhkK50C771V4W1ldLsmFGTwwktI=;
        b=YeystnvciSwKReYcfXaeUCeufGiQ3WDdKA06Zcwljax6tS+Lj6hug0CB7jrIPEKKFp
         +/UAcVkBJA/a0SNnbcdARmlwbV5UjvMdjjNbn8U33x5Wd8ZF242l6KHQDCsZ+ffUaKy0
         +ID1TcIbGs3Tg7VYl87eR87t9DrGd6QGaedjqjO5LJ5Px7mElT3c6wn2eMeiLY8AeGCY
         iZ9Tv+bVFWOoyZrXOh3jt+p7x0mSLjLREMsdEeNQemO1YHFYs/JNsuXqlgeonfw2LoVI
         bR5oqZzyEklSwfdM3/QOdlditppsJROIvNLfgsx4sKri7R0Vd5CwrnJ5/CG3Zwai5FuK
         qKxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379692; x=1774984492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ngqb+DmGtwEG3FK8sIpZyt2ZJ6Tw4EzBiHu4t/MVsn4=;
        b=T9aqoVlckmMIPxB57yHaHwIhPstPJo4/t7SFLCOqCbnI0M812VN0j/fz9rfmSIRlxR
         cEDj+kfu2zy1n09r2UJfBOAe+RRDSZc3hZL/+GoDIWQoe/4pzFx9iCCh6Ug9om5b+GZW
         S2UxEGlS42A92rlhugWsk8DG6Hcyu0OX4qz9sGjIkMzCbm6MKbn4/PKi+Fc5rErWp22K
         NB29/j3HmbxQ0WDSfyxWFOEjpV4dCVGNGp16WlP7xp7apAiZXY85wDLQYYTxQCKWCi9u
         BrKIpCnAEPzQNk4Ka7tvx+TywRHOzHOERO/fRtfm3TF6dBenLzDMvF1Xg6PQZyzx5roY
         Z31w==
X-Forwarded-Encrypted: i=1; AJvYcCXj/aXjoK7juoDufGwbiAPrIAndc38KWbc+puMmkcAg8Bmdy/uSYWeFiHbqStPM/lUUtDQ0yjlj8D8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFAiFVKUeFWi2NVflT+fqbak9KDXQ8hipXS18ckvVpmCS4ygA
	jGqWFeH5+wfLdnqz15H8fHSGVf4YZsdiuEGR6OJKHfkzJPu7XaZq5Cmvf51CpipJSoHO3RZ3HnS
	2ZS/SQq46ivZfcOko/lYvXublmQjkryLHMNgNywdMxlEu+SafLxUIwG7M2XRv1zJhmQIIaaGnwF
	mq8hTAF4WVE9vN7aYzPlbo/uWknY6HWCJweFjWMj1W2jeKqLqi0GGd
X-Gm-Gg: ATEYQzwx3dMHNNI+FNmloVhn2G2/b/7uoF/mXdFo74BFXEGWDPjqhxNm2tPm1ksojeC
	AYzyRGEsC4ylq8qdPh2Wrqz+gAIkYAZ5SE/YFs501IZufhgGoj83yFq9d1upfiVlyb7Jc0dxGvK
	ZxPP/UfCMlSnipWU0UIacDnO0+AooZPh58RlBWmW90XbrWnCWcdtO6B22cyhVVfIV8zK4uzWlfa
	0KnAD9+7hTm0kKYqqwz2EgbZ0RHgTX33v/2jN8=
X-Received: by 2002:a17:907:7fac:b0:b8f:d2a0:c283 with SMTP id a640c23a62f3a-b99ae1f7d0cmr36034466b.1.1774379692057;
        Tue, 24 Mar 2026 12:14:52 -0700 (PDT)
X-Received: by 2002:a17:907:7fac:b0:b8f:d2a0:c283 with SMTP id
 a640c23a62f3a-b99ae1f7d0cmr36028866b.1.1774379691469; Tue, 24 Mar 2026
 12:14:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313094618.1361418-1-ziyue.zhang@oss.qualcomm.com>
 <20260313164542.GA1405513@bhelgaas> <en5a7jrgpbn4bsmw5qwprugb2qmjkqw2x5eey6jxxu63634duz@b43rhcsqkj3o>
 <abdviJbrluDn2Vrx@baldur> <kqpgjzcxnazjohiop27exget6qrv37wn3csmixt5nmc6d5dkbg@n7qjo6flaabn>
 <abtgaXSv-zRysJqO@baldur> <4byysnjodmlphwcevw5gb2asxbwwwlf526mtpwpkfi6crjxoqb@vyuktezfu2wu>
 <CAARv3RSag8n0=ut9KGm0yALRPVTiyQ+bBBbT+3Vf1sNOCBLbGA@mail.gmail.com> <dnx4ge2e2zy2unw5jtmmhktyzlnmmhrogb5skskxewi6y7ekau@vpfdphzay7td>
In-Reply-To: <dnx4ge2e2zy2unw5jtmmhktyzlnmmhrogb5skskxewi6y7ekau@vpfdphzay7td>
From: Tobias Heider <tobias.heider@canonical.com>
Date: Tue, 24 Mar 2026 20:14:39 +0100
X-Gm-Features: AaiRm50Xa8MYmaP0uH8BT8rSPTXsqKVKZcUFfeHqOG5ZpI8OP5QNHanLv-y60Mk
Message-ID: <CAARv3RRqXxNePX=4RqnLu7OnfjQmStynsL9RCNY19EKQOTcnLQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] arm64: dts: qcom: hamoa: Move PCIe PERST and Wake
 GPIOs to port nodes
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, 
	Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 7:07=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Thu, Mar 19, 2026 at 02:50:37PM +0100, Tobias Heider wrote:
> > Resending because the previous mail ended up being HTML (sorry)
> >
> > On Thu, Mar 19, 2026 at 6:39=E2=80=AFAM Manivannan Sadhasivam <mani@ker=
nel.org> wrote:
> > >
> > > On Wed, Mar 18, 2026 at 09:42:56PM -0500, Bjorn Andersson wrote:
> > > > On Mon, Mar 16, 2026 at 08:50:12AM +0530, Manivannan Sadhasivam wro=
te:
> > > > > On Sun, Mar 15, 2026 at 09:53:33PM -0500, Bjorn Andersson wrote:
> > > > > > On Sat, Mar 14, 2026 at 07:50:50PM +0530, Manivannan Sadhasivam=
 wrote:
> > > > > > > On Fri, Mar 13, 2026 at 11:45:42AM -0500, Bjorn Helgaas wrote=
:
> > > > > > > > On Fri, Mar 13, 2026 at 05:46:18PM +0800, Ziyue Zhang wrote=
:
> > > > > > > > > Commit 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, =
PERST, and Wake
> > > > > > > > > GPIOs to PCIe port nodes and add port Nodes for all PCIe =
ports") did not
> > > > > > > > > convert all Hamoa=E2=80=91based platforms to the new meth=
od of defining PERST and
> > > > > > > > > Wake GPIOs in the PCIe root port nodes.
> > > > > > > > >
> > > > > > > > > Without the change PCIe probe will fail. The probe failur=
e happens because
> > > > > > > > > the PHY stays in the controller node while the PERST/Wake=
 GPIOs were moved
> > > > > > > > > to the port nodes.
> > > > > > > > >
> > > > > > > > > This fixes probe failures seen on the following platforms=
:
> > > > > > > > >  - x1-hp-omnibook-x14
> > > > > > > > >  - x1-microsoft-denali
> > > > > > > > >  - x1e80100-lenovo-yoga-slim7x
> > > > > > > > >  - x1e80100-medion-sprchrgd-14-s1
> > > > > > > > >  - x1p42100-lenovo-thinkbook-16
> > > > > > > > >  - x1-asus-zenbook-a14
> > > > > > > > >  - x1-crd
> > > > > > > > >  - x1-dell-thena
> > > > > > > > >
> > > > > > > > > Fixes: 960609b22be5 ("arm64: dts: qcom: hamoa: Move PHY, =
PERST, and Wake GPIOs to PCIe port nodes and add port Nodes for all PCIe po=
rts")
> > > > > > > >
> > > > > > > > Are you saying that DTs in the field broke because of some =
kernel
> > > > > > > > change?  That's not supposed to happen.  Even though PHY, P=
ERST, and
> > > > > > > > Wake GPIOs should be described in Root Port nodes instead o=
f the Root
> > > > > > > > Complex node in *future* DTs, the kernel is still supposed =
to accept
> > > > > > > > the old style with them described in the Root Complex node.
> > > > > > > >
> > > > > > >
> > > > > > > This is not related to the driver change. The driver correctl=
y parses all Root
> > > > > > > Port properties either in the Root Complex node (old binding)=
 or Root Port node
> > > > > > > (new binding). But commit 960609b22be5, left converting menti=
oned board DTS to
> > > > > > > the new binding, leaving those affected platforms in a half b=
aked state i.e.,
> > > > > > > some properties in RC node and some in Root Port node. Driver=
 cannot parse such
> > > > > > > combinations, so it fails correctly so.
> > > > > > >
> > > > > >
> > > > > > Are you saying that above listed machines has broken PCIe suppo=
rt in
> > > > > > v7.0-rc?
> > > > > >
> > > > >
> > > > > I haven't verified it, but I'm pretty sure PCIe is broken on thes=
e platforms.
> > > > >
> > > >
> > > > In line with Bjorn's request, we shouldn't have to guess.
> > > >
> > > > > > It seems this is a (partial) revert of 960609b22be5, is this ac=
tually
> > > > > > fixing that change, or is it only applicable once some other ch=
anges are
> > > > > > applied?
> > > > > >
> > > > >
> > > > > This change is fixing the issue in the respective board DTS and i=
s a standalone
> > > > > fix on top of v7.0-rc1.
> > > > >
> > > >
> > > > So 960609b22be5 was broken when I merged it?
> > > >
> > >
> > > Broken on the machines mentioned in the commit message, not for all H=
amoa
> > > platforms.
> > >
> > > > The commit message says that the commit was incomplete, in that it
> > > > didn't fully convert from the old to the new style, so it sounds li=
ke
> > > > the offending commit was incomplete - but I believe the offending c=
ommit
> > > > was a workaround for the new solution not being in place and this c=
ommit
> > > > mostly reverts the changes in the offending commit.
> > > >
> > >
> > > So 960609b22be5 was supposed to move all the platforms from old PCIe =
binding to
> > > new for greater good, but it apparently decided to do so only for a s=
ubset of
> > > the platforms for some reason which  don't know. But the problem aris=
es due to
> > > 960609b22be5 changing the hamoa.dtsi to the new binding which also wa=
rrants the
> > > platform DTS to also be changed to the new binding. If we only have e=
ither dtsi
> > > or dts converted and not both to the new binding, the driver will get=
 confused
> > > and fail. And this is what exactly happended for below machines:
> > >
> > >  - x1-hp-omnibook-x14
> > >  - x1-microsoft-denali
> > >  - x1e80100-lenovo-yoga-slim7x
> > >  - x1e80100-medion-sprchrgd-14-s1
> > >  - x1p42100-lenovo-thinkbook-16
> > >  - x1-asus-zenbook-a14
> > >  - x1-crd
> > >  - x1-dell-thena
> >
> > I can confirm the breakage for (some of) the listed devices on Ubuntu.
> > We are experimenting with 7.0-rcs ahead of our 26.04 release.
> >
> > I'll try to collect some test feedback for the fix.
> > I'd certainly appreciate this being included as an rc fix since
> > currently half of
> > the x1 laptop devices are broken.
> >
>
> Thanks for the report. We will try to get this patch into v7.0-rcS.
>
> It'd be appreciated if you can test this patch and give your tested-by ta=
g.
>
> - Mani

Thank you!

Tested it myself and I have rolled this out to my ubuntu-concept testing re=
po.
I have tested the CRD and got user feedback that it works on at least an
Omnibook (where we first saw the regression without the patch) and Lenovo Y=
oga.
Potentially more but not everyone provides feedback when things don't break=
.

Tested-by: Tobias Heider <tobias.heider@canonical.com>

>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
