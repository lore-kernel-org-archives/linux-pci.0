Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53571 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754684Ab2CSXNB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2012 19:13:01 -0400
Message-ID: <4F67BD78.8070202@gmail.com>
Date: Tue, 20 Mar 2012 00:12:56 +0100
From: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>,
	Grant Likely <grant.likely@secretlab.ca>
CC: linux-tegra@vger.kernel.org, Liam Girdwood <lrg@ti.com>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 01/11] drivercore: Add driver probe deferral mechanism
References: <1331218291-16119-1-git-send-email-thierry.reding@avionic-design.de> <1331218291-16119-2-git-send-email-thierry.reding@avionic-design.de>
In-Reply-To: <1331218291-16119-2-git-send-email-thierry.reding@avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/08/2012 03:51 PM, Thierry Reding wrote:
> From: Grant Likely<grant.likely@secretlab.ca>
>
> Allow drivers to report at probe time that they cannot get all the resources
> required by the device, and should be retried at a later time.
>
> This should completely solve the problem of getting devices
> initialized in the right order.  Right now this is mostly handled by
> mucking about with initcall ordering which is a complete hack, and
> doesn't even remotely handle the case where device drivers are in
> modules.  This approach completely sidesteps the issues by allowing
> driver registration to occur in any order, and any driver can request
> to be retried after a few more other drivers get probed.
>
> v4: - Integrate Manjunath's addition of a separate workqueue
>      - Change -EAGAIN to -EPROBE_DEFER for drivers to trigger deferral
>      - Update comment blocks to reflect how the code really works
> v3: - Hold off workqueue scheduling until late_initcall so that the bulk
>        of driver probes are complete before we start retrying deferred devices.
>      - Tested with simple use cases.  Still needs more testing though.
>        Using it to get rid of the gpio early_initcall madness, or to replace
>        the ASoC internal probe deferral code would be ideal.
> v2: - added locking so it should no longer be utterly broken in that regard
>      - remove device from deferred list at device_del time.
>      - Still completely untested with any real use case, but has been
>        boot tested.
>
> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
> [Cc list stripped in order not to get on people's nerves]
> ---
>   drivers/base/base.h    |    1 +
>   drivers/base/core.c    |    2 +
>   drivers/base/dd.c      |  138 +++++++++++++++++++++++++++++++++++++++++++++++-
>   include/linux/device.h |    5 ++
>   include/linux/errno.h  |    1 +
>   5 files changed, 146 insertions(+), 1 deletion(-)

Is this patch going to be included in v3.4 ? I can see it's in -next,
but not sure where I could check if its really queued for v3.4.
It would be nice to have it in v3.4, I've got already one more client
of this deferred probe infrastructure.

--

Thanks,
Sylwester
