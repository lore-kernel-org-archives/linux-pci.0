Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:65429 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbaGHHcB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jul 2014 03:32:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V8 0/9] PCI: Add SPEAr13xx PCie support
Date: Tue, 8 Jul 2014 09:31:47 +0200
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Pratyush ANAND <pratyush.anand@st.com>,
	"'Bjorn Helgaas' (bhelgaas@google.com)" <bhelgaas@google.com>,
	"spear-devel" <spear-devel@list.st.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mark Nicholson <mark@nicholnet.com>
References: <cover.1397555158.git.mohit.kumar@st.com> <2CC2A0A4A178534D93D5159BF3BCB661A17A3E4639@EAPEX1MAIL1.st.com> <CAOh2x=naoa8a1v7Pk+Qv-Fha34ezp6OqBXVwsh_p=guCZgXFrA@mail.gmail.com>
In-Reply-To: <CAOh2x=naoa8a1v7Pk+Qv-Fha34ezp6OqBXVwsh_p=guCZgXFrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201407080931.47673.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday 08 July 2014, Viresh Kumar wrote:
> On Tue, Jul 8, 2014 at 10:54 AM, Mohit KUMAR DCG <Mohit.KUMAR@st.com> wrote:
> > Pls find attached patches to push through your repo.  These are rebased over the top
> >  of 3.16-rc3.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git
> spear/pcie-support-v8

I'm currently at the Linaro sprint in Le Mans, so Olof is doing all the arm-soc merges.
Mohit or Pratyush, please send a formal pull request (using "git request-pull") to
arm@kernel.org with Cc to everyone on Cc here so Olof can pick it up.

Please also include a description of the overall series and the reasons why we decided
to merge it through arm-soc in the pull request email. Thanks!

	Arnd
