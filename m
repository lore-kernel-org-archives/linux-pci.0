Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:41416 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab2GKGJd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jul 2012 02:09:33 -0400
Received: by vcbf11 with SMTP id f11so530237vcb.19
        for <linux-pci@vger.kernel.org>; Tue, 10 Jul 2012 23:09:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OF259177D8.B20ED592-ONC1257A38.00167C85-C1257A38.0016C890@transmode.se>
References: <OF15EE971A.73D0AED3-ONC1257A37.005D93BD-C1257A37.00601BF9@transmode.se>
	<CAE9FiQV3-x64CbkPGVDNLzDkiuteQyvxpU56U_paVbyXavifmQ@mail.gmail.com>
	<OF9D2FB397.4951E6E4-ONC1257A37.0076FA3B-C1257A37.0077405A@transmode.se>
	<CAE9FiQXMaPBc7o0KhSBAoAHRP=+1aqemvUBZjJd3bANXoFtqyA@mail.gmail.com>
	<OF9DA7C6E4.12BE1316-ONC1257A38.000618C1-C1257A38.00062838@transmode.se>
	<CAE9FiQVYt5sp9rQ1=L6ak4LJG1ot4WQ_nq8-t3qvmtpT_TRJLg@mail.gmail.com>
	<OF259177D8.B20ED592-ONC1257A38.00167C85-C1257A38.0016C890@transmode.se>
Date: Tue, 10 Jul 2012 23:09:32 -0700
Message-ID: <CAE9FiQUq-ZSiAK_wfTe=s=dpdYDsQe7pOWF_iMcsZg2dUtLRUg@mail.gmail.com>
Subject: Re: PICe hotplug problems
From: Yinghai Lu <yinghai@kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 10, 2012 at 9:08 PM, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
>> please check link disable patch at
>> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
>> for-pci-pcie-link
>
> Thanks, that was really quick. However, the patches does not apply on my
> 3.4 kernel and it looks non trivial to me fixup.
>
> Could you create (even quick and dirty) patches on top of 3.4?

you can just use that branch instead.

mkdir linux-2.6 || exit -1
cd linux-2.6

git init-db
# Add Linus's tree as a remote
git remote add linus
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

git remote add yh
git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git

git remote update

git checkout -b yh_2012_07_10 yh/for-pci-pcie-link
