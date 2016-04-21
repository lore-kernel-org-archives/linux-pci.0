Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57427 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083AbcDUTfi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 21 Apr 2016 15:35:38 -0400
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+JO41w2PweW0n1Z78=wPnYh+wfa==Hb8o37L3ynDndkA@mail.gmail.com>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be> <CAL_Jsq+JO41w2PweW0n1Z78=wPnYh+wfa==Hb8o37L3ynDndkA@mail.gmail.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 21 Apr 2016 14:35:15 -0500
Message-ID: <CAL_JsqLr+vS4BB9qvkrbg93Ypm8yhzs6eqESQFpjkL5_fv+jkw@mail.gmail.com>
Subject: Re: [PATCH 00/14] DT: Fix spelling of standard properties
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vinod Koul <vinod.koul@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Joe Perches <joe@perches.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	dmaengine@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 20, 2016 at 6:58 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Wed, Apr 20, 2016 at 10:32 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>>         Hi all,
>>
>> This patch series fixes misspellings of various standard DT properties
>> in DT binding documentation, DTS files, and error messages.
>> While most of these are harmless, some of them may cause hard-to-debug
>> failures.
>>
>> Please apply where appropriate.
>
> I'll happily take the whole series if you like, though I've not
> reviewed it all yet.

Now, I have. Other than patch 4 and 14, for the series:

Acked-by: Rob Herring <robh@kernel.org>

Rob
