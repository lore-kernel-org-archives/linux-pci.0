Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:60340 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752444Ab2J2HWx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 03:22:53 -0400
Message-ID: <508E2EBB.6040905@st.com>
Date: Mon, 29 Oct 2012 12:52:35 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: viresh kumar <viresh.kumar@linaro.org>
Cc: "arm@kernel.org" <arm@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>
Subject: Re: [PATCH 00/15] SPEAr13xx PCIe patches
References: <cover.1351492562.git.pratyush.anand@st.com> <CAOh2x=mFS7awO7eoD4zA-sEzg0wY8KNjzTCcXMhOrqBhRcodKA@mail.gmail.com>
In-Reply-To: <CAOh2x=mFS7awO7eoD4zA-sEzg0wY8KNjzTCcXMhOrqBhRcodKA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Viresh,

On 10/29/2012 12:46 PM, viresh kumar wrote:
> On Mon, Oct 29, 2012 at 12:31 PM, Pratyush Anand <pratyush.anand@st.com> wrote:
>> -- First two patches are common for all platforms on ARM architecture.
>> -- Remaining patches belongs to SPEAr13xx architecture.
>> -- SPEAr13xx supports both RC and EP mode of PCIe interface. This patchset
>>          supports only RC mode.
>
> Hi Pratyush,
>
> For ARM SoC specific patches, that you want Arnd or Olof to apply, please send
> them to arm@kernel.org. Arnd and Olof push ARM SoC trees in turns and they
> pick them from arm@kernel.org.

Ok, I will wait for few days if any more comment is received, and V2 is 
needed then will take care during v2, else I will resend V1 to this id 
after few days.


>
> --
> viresh
> .
>


