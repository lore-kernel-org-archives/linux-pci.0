Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from exprod7og125.obsmtp.com ([64.18.2.28]:34052 "EHLO
	exprod7og125.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806Ab2HJSwH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 10 Aug 2012 14:52:07 -0400
Message-ID: <50255849.6070307@genband.com>
Date: Fri, 10 Aug 2012 12:51:53 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@ics.muni.cz>
CC: Yinghai Lu <yinghai@kernel.org>, Roland Dreier <roland@kernel.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: mellanox mlx4_core and SR-IOV
References: <20120801133835.GH5470@ics.muni.cz> <CAG4TOxONLJnBaY7N5x7Kfi+dwCb507QPqX9s_Wuef10+RzM=AQ@mail.gmail.com> <CAE9FiQUSFeBpGaFByOfENUa8qg7t89WTiUann8=4ezT7s2qmzw@mail.gmail.com> <20120801205640.GN5470@ics.muni.cz> <CAE9FiQWmgyirjjCwn54PkAsfvWxZSY5RhRVDkhhbK7E0NPzqaw@mail.gmail.com> <20120801220802.GP5470@ics.muni.cz> <CAE9FiQW84gjtX=_4guCBgcAJmkAGQ5ooFoj7C_29K7QK0s9qwA@mail.gmail.com> <20120803083344.GF25979@ics.muni.cz>
In-Reply-To: <20120803083344.GF25979@ics.muni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 08/03/2012 02:33 AM, Lukas Hejtmanek wrote:
> I also tried OFED package from Mellanox which seems to have better SR-IOV
> support (at least mlx4_ib does not complain that SR-IOV is not supported).
> However, it does not work when SR-IOV enabled:

Last I heard they were not officially providing support for SR-IOV.  Has 
anyone heard otherwise from the Mellanox folks?

Chris


